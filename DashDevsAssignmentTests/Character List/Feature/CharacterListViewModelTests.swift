//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

final class CharacterListViewModelTests: XCTestCase {

    func test_title() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.title, "Characters")
    }
    
    func test_filters_areEmptyOnInit() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.filters, [])
    }
    
    // MARK: - Helpers
    private func makeSUT() -> CharacterListViewModel {
        let sut = CharacterListViewModel()
        
        return sut
    }
}
