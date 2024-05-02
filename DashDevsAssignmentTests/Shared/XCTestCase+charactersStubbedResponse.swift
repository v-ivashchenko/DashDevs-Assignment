//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

extension XCTestCase {
    
    func charactersStubbedResponse(characters: [GetAllCharactersMapper.Character]) -> (Data, HTTPURLResponse) {
        let result = makeGetAllCharactersResponse(characters: characters)
        let json = makeJSON(result.json)
        let expectedResponse = HTTPURLResponse(statusCode: 200)
        
        return (json, expectedResponse)
    }
}
