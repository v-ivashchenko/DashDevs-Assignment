//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

struct GetImageForCharacterRequest {
    
    static func request(to url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
}
