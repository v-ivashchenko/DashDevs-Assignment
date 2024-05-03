//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

final class GetAllCharactersRequestTests: XCTestCase {
    
    func test_request_returnsConcreteRequest() {
        let sut = GetAllCharactersRequest.request(to: baseURL, page: 1)
        
        XCTAssertEqual(sut.httpMethod, "GET")
        XCTAssertEqual(sut.url?.absoluteString, baseURL.absoluteString + "/api/character?page=1")
        XCTAssertNil(sut.httpBody)
    }
}
