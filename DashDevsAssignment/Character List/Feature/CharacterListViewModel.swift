//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

class CharacterListViewModel {
    
    private let client: HTTPClient
    
    private(set) var title = "Characters"
    private(set) var filters = [String]()
    
    init(client: HTTPClient) {
        self.client = client
    }
}
