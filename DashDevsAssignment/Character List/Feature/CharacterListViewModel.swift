//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

class CharacterListViewModel {
    
    private let client: HTTPClient
    private let baseURL: URL
    private let imageCache: ImageCache
    private let queue = DispatchQueue(label: Bundle.main.bundleIdentifier ?? "")
    private var currentPage = 0
    private var nextPage: String?
    private var fetchNextPageTask: Task<Void, Error>?
    
    private(set) var title = "Characters"
    private(set) var filters = CharacterStatus.allCases.map { $0.title.capitalized }
    private(set) var selectedFilters = Set(CharacterStatus.allCases.map { $0.title.capitalized })
    private(set) var characters = [CharacterListCellViewModel]()
    private(set) var filteredCharacters = [CharacterListCellViewModel]()
    
    var numberOfRowsInSection: Int {
        filteredCharacters.count
    }
    
    var distanceFromEndCell: Int {
        characters.count - 5
    }
    
    init(client: HTTPClient, baseURL: URL, imageCache: ImageCache) {
        self.client = client
        self.baseURL = baseURL
        self.imageCache = imageCache
    }
    
    func cellViewModel(
        at indexPath: IndexPath,
        imageLoadingCompletion: @escaping (UIImage) -> Void
    ) -> CharacterListCellViewModel {
        queue.async {
            if self.filteredCharacters[indexPath.row].image == nil {
                Task {
                    let image = try await self.loadImage(at: indexPath)
                    
                    await MainActor.run {
                        imageLoadingCompletion(image)
                    }
                }
            }
        }
        
        return filteredCharacters[indexPath.row]
    }
    
    func fetchNextPage(completion: @escaping () -> Void) {
        guard fetchNextPageTask == nil else { return }
        guard currentPage == 0 || nextPage != nil else { return }
        
        fetchNextPageTask = Task {
            currentPage += 1
            let request = GetAllCharactersRequest.request(to: baseURL, page: currentPage)
            let (data, response) = try await client.data(for: request)
            
            try queue.sync {
                let mappedResponse = try GetAllCharactersMapper.map(data: data, from: response)
                nextPage = mappedResponse.info.next
                
                characters.append(contentsOf: mappedResponse
                    .results.map {
                        .init(
                            id: String($0.id),
                            name: $0.name,
                            species: $0.species,
                            imagePath: $0.image,
                            status: CharacterStatus(rawValue: $0.status),
                            gender: $0.gender,
                            location: $0.location.name
                        )
                    }
                )
                filteredCharacters = characters
            }
            
            await MainActor.run {
                fetchNextPageTask = nil
                completion()
            }
        }
    }
    
    func filter(by title: String, completion: @escaping (Set<String>) -> Void) {
        Task {
            queue.sync {
                if selectedFilters.contains(title) {
                    selectedFilters.remove(title)
                } else {
                    selectedFilters.insert(title)
                }
                
                filteredCharacters = selectedFilters.isEmpty ? characters : characters.filter { selectedFilters.contains($0.status.title) }
            }
            
            await MainActor.run {
                completion(selectedFilters)
            }
        }
    }
    
    private func loadImage(at indexPath: IndexPath) async throws -> UIImage {
        let character = queue.sync {
            filteredCharacters[indexPath.row]
        }
        
        if let image = try await imageCache.image(by: character.imagePath) {
            assignImage(image, at: indexPath, for: character)
            
            return image
        } else {
            guard let imageURL = character.imageURL else { throw URLError(.badURL) }
            let (data, response) = try await client.data(for: GetImageForCharacterRequest.request(to: imageURL))
            let imageData = try GetImageForCharacterMapper.map(data: data, from: response)
            let image = UIImage(data: imageData) ?? UIImage()
            
            try await imageCache.setImage(image, by: character.imagePath)
            assignImage(image, at: indexPath, for: character)
            
            return image
        }
    }
    
    private func assignImage(_ image: UIImage, at indexPath: IndexPath, for character: CharacterListCellViewModel) {
        queue.sync {
            var viewModel = character
            viewModel.image = image
            
            if let index = characters.firstIndex(where: { $0.imagePath == character.imagePath }) {
                characters[index] = viewModel
            }
            
            if let index = filteredCharacters.firstIndex(where: { $0.imagePath == character.imagePath }) {
                filteredCharacters[index] = viewModel
            }
        }
    }
}
