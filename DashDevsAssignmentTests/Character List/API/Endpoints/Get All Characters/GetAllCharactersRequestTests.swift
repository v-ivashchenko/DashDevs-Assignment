//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

final class GetAllCharactersRequestTests: XCTestCase {
    
    func test_request_returnsConcreteRequest() {
        let sut = GetAllCharactersRequest.request(to: baseURL)
        
        XCTAssertEqual(sut.httpMethod, "GET")
        XCTAssertEqual(sut.url, baseURL.appending(path: "api/character"))
        XCTAssertNil(sut.httpBody)
    }
}
