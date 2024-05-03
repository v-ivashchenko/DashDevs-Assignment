//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

struct GetAllCharactersRequest {
    
    static func request(to baseURL: URL, page: Int) -> URLRequest {
        let url = baseURL
            .appending(path: "api/character")
            .appending(queryItems: [.init(name: "page", value: String(page))])
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
}
