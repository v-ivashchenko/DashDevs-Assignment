//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

struct GetAllCharactersMapper {
    
    struct Response: Decodable, Equatable {
        let info: Info
        let results: [Character]
    }
    
    struct Info: Decodable, Equatable {
        let next: String?
        let prev: String?
    }
    
    struct Character: Decodable, Equatable {
        let id: Int
        let name: String
        let status: String
        let species: String
        let gender: String
        let image: String
    }
    
    enum Error: Swift.Error, Equatable {
        case invalidData
        case invalidStatusCode(Int)
    }
    
    static func map(data: Data, from response: HTTPURLResponse) throws -> Response {
        guard response.statusCode == 200 else { throw Error.invalidStatusCode(response.statusCode) }
        guard let decodedData = try? JSONDecoder().decode(Response.self, from: data) else { throw Error.invalidData }
        
        return decodedData
    }
}
