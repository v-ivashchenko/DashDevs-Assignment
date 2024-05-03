//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

class CharacterListViewModel {
    
    private let client: HTTPClient
    private let baseURL: URL
    private let imageCache: ImageCache
    private let queue = DispatchQueue(label: Bundle.main.bundleIdentifier ?? "")
    
    private(set) var title = "Characters"
    private(set) var filters = [String]()
    private(set) var characters = [CharacterListCellViewModel]()
    
    var numberOfRowsInSection: Int {
        characters.count
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
            if self.characters[indexPath.row].image == nil {
                Task {
                    let image = try await self.loadImage(at: indexPath)
                    
                    await MainActor.run {
                        imageLoadingCompletion(image)
                    }
                }
            }
        }
        
        return characters[indexPath.row]
    }
    
    func fetchFirstPage(completion: @escaping () -> Void) {
        Task {
            let request = GetAllCharactersRequest.request(to: baseURL)
            let (data, response) = try await client.data(for: request)
            
            try queue.sync {
                characters = try GetAllCharactersMapper.map(data: data, from: response)
                    .results
                    .map {
                        .init(id: String($0.id), name: $0.name, species: $0.species, imagePath: $0.image)
                    }
            }
            
            await MainActor.run {
                completion()
            }
        }
    }
    
    private func loadImage(at indexPath: IndexPath) async throws -> UIImage {
        let character = queue.sync {
            characters[indexPath.row]
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
        }
    }
}
