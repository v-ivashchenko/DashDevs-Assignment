//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

final class CharacterListViewControllerTests: XCTestCase {

    func test_dataSource_isSet() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func test_numberOfRowsInSection_equalsZeroOnViewDidLoad() {
        let sut = makeSUT()
        
        let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        
        XCTAssertEqual(numberOfRows, 0)
    }
    
    // MARK: - Helpers
    private func makeSUT() -> CharacterListViewController {
        let sut = CharacterListViewController()
        
        sut.loadViewIfNeeded()
        
        return sut
    }
}
