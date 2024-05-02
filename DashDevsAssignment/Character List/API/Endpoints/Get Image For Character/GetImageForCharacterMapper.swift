//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

struct GetImageForCharacterMapper {
        
    enum Error: Swift.Error, Equatable {
        case invalidStatusCode(Int)
    }
    
    static func map(data: Data, from response: HTTPURLResponse) throws -> Data {
        guard response.statusCode == 200 else { throw Error.invalidStatusCode(response.statusCode) }
        
        return data
    }
}
