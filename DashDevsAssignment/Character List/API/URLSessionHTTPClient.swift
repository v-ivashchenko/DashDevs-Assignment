//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

class URLSessionHTTPClient: HTTPClient {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func data(for request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw NSError(domain: Bundle.main.bundleIdentifier ?? "", code: -1)
        }
        
        return (data, response)
    }
}
