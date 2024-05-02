//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

final class GetImageForCharacterRequestTests: XCTestCase {

    func test_request_returnsConcreteRequest() {
        let expectedURL = anyURL()
        let sut = GetImageForCharacterRequest.request(to: expectedURL)
        
        XCTAssertEqual(sut.httpMethod, "GET")
        XCTAssertEqual(sut.url, expectedURL)
        XCTAssertNil(sut.httpBody)
    }
}
