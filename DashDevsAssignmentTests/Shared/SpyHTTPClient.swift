//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import Foundation
@testable import DashDevsAssignment

class SpyHTTPClient: HTTPClient {
    
    enum Message: Equatable {
        case data(URLRequest)
    }
    
    let stubbedResponse: (Data, HTTPURLResponse)
    var messages = [Message]()
    
    init(stubbedResponse: (Data, HTTPURLResponse)) {
        self.stubbedResponse = stubbedResponse
    }
    
    func data(for request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        messages.append(.data(request))
        
        return stubbedResponse
    }
}
