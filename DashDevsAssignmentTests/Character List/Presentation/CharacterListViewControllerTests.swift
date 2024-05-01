//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

final class CharacterListViewControllerTests: XCTestCase {

    func test_dataSource_isSet() {
        let sut = CharacterListViewController()
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func test_numberOfRowsInSection_equalsZeroOnViewDidLoad() {
        let sut = CharacterListViewController()
        
        sut.loadViewIfNeeded()
        let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        
        XCTAssertEqual(numberOfRows, 0)
    }
}
