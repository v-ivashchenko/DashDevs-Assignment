//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

class CharacterListViewModel {
    
    private let client: HTTPClient
    private let baseURL: URL
    
    private(set) var title = "Characters"
    private(set) var filters = [String]()
    private(set) var characters = [CharacterListCellViewModel]()
    
    var numberOfRowsInSection: Int {
        characters.count
    }
    
    init(client: HTTPClient, baseURL: URL) {
        self.client = client
        self.baseURL = baseURL
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CharacterListCellViewModel {
        characters[indexPath.row]
    }
    
    func fetchFirstPage(completion: @escaping () -> Void) {
        Task {
            let request = GetAllCharactersRequest.request(to: baseURL)
            let (data, response) = try await client.data(for: request)
            
            characters = try GetAllCharactersMapper.map(data: data, from: response)
                .results
                .map {
                    .init(id: String($0.id), name: $0.name, species: $0.species, image: nil)
                }
            
            completion()
        }
    }
}
