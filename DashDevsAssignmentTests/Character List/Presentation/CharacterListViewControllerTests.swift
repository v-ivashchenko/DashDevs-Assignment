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
    
    func test_cellForRowAt_isConcreteCellType() {
        let sut = makeSUT(characters: [makeCharacter()])
        
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is CharacterListCell)
    }
    
    // MARK: - Helpers
    private func makeSUT(
        characters: [GetAllCharactersMapper.Character] = [],
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> CharacterListViewController {
        let client = SpyHTTPClient(stubbedResponse: charactersStubbedResponse(characters: characters))
        let viewModel = CharacterListViewModel(client: client, baseURL: baseURL)
        let sut = CharacterListViewController(viewModel: viewModel)
        
        sut.loadViewIfNeeded()
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return sut
    }
}
