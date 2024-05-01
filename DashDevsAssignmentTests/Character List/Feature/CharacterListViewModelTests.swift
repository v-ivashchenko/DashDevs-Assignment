//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

final class CharacterListViewModelTests: XCTestCase {

    func test_title() {
        let sut = CharacterListViewModel()
        
        XCTAssertEqual(sut.title, "Characters")
    }
    
    func test_filters_areEmptyOnInit() {
        let sut = CharacterListViewModel()
        
        XCTAssertEqual(sut.filters, [])
    }
}
