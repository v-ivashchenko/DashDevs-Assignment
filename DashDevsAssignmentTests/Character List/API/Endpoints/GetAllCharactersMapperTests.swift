//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

final class GetAllCharactersMapperTests: XCTestCase {

    func test_map_throwsErrorOnNon200HTTPResponse() {
        let samples = [199, 201, 300, 400, 500]
        
        samples.forEach { code in
            expectToCompleteWith(statusCode: code, expectedError: .invalidStatusCode(code))
        }
    }
    
    // MARK: - Helpers
    private func expectToCompleteWith(
        data: Data = anyData,
        statusCode: Int,
        expectedError: GetAllCharactersMapper.Error,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertThrowsError(try GetAllCharactersMapper.map(
            data: data,
            from: HTTPURLResponse(url: baseURL, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        )) { error in
            XCTAssertEqual(error as? GetAllCharactersMapper.Error, expectedError, file: file, line: line)
        }
    }
}
