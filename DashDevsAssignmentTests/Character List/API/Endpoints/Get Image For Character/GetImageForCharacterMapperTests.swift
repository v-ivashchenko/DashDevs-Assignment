//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

final class GetImageForCharacterMapperTests: XCTestCase {

    typealias SUT = GetImageForCharacterMapper
    
    func test_map_throwsErrorOnNon200HTTPResponse() {
        let samples = [199, 201, 300, 400, 500]
        
        samples.forEach { code in
            expectToCompleteWith(statusCode: code, expectedError: .invalidStatusCode(code))
        }
    }
    
    func test_map_deliversResultOn200HTTPResponseWithValidData() throws {
        let expectedData = anyData
        
        let mappedResponse = try SUT.map(data: expectedData, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(mappedResponse, expectedData)
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
