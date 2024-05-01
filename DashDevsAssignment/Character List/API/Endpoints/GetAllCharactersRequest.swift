//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

struct GetAllCharactersRequest {
    
    static func request(to baseURL: URL) -> URLRequest {
        let url = baseURL.appending(path: "api/character")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
}
