//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

final class GetAllCharactersMapperTests: XCTestCase {
    
    typealias SUT = GetAllCharactersMapper
    
    func test_map_throwsErrorOnNon200HTTPResponse() {
        let samples = [199, 201, 300, 400, 500]
        
        samples.forEach { code in
            expectToCompleteWith(statusCode: code, expectedError: .invalidStatusCode(code))
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidData() {
        let data = Data("invalid data".utf8)
        
        expectToCompleteWith(data: data, statusCode: 200, expectedError: .invalidData)
    }
    
    func test_map_deliversResultOn200HTTPResponseWithValidData() throws {
        let result = makeGetAllCharactersResponse(characters: [makeCharacter()])
        let json = makeJSON(result.json)
        
        let mappedResponse = try SUT.map(data: json, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(mappedResponse, result.model)
    }
    
    // MARK: - Helpers
    private func expectToCompleteWith(
        data: Data = anyData,
        statusCode: Int,
        expectedError: SUT.Error,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertThrowsError(try SUT.map(data: data, from: HTTPURLResponse(statusCode: statusCode))) { error in
            XCTAssertEqual(error as? SUT.Error, expectedError, file: file, line: line)
        }
    }
}
