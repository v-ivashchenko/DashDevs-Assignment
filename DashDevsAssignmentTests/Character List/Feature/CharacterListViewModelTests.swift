//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

final class CharacterListViewModelTests: XCTestCase {

    func test_title() {
        let (sut, _) = makeSUT()
        
        XCTAssertEqual(sut.title, "Characters")
    }
    
    func test_filters_areNotEmpty() {
        let (sut, _) = makeSUT()
        
        XCTAssertFalse(sut.filters.isEmpty)
    }
    
    func test_fetchNextPage_mustCompleteOnMainThread() {
        let (sut, _) = makeSUT()
        let expectation = self.expectation(description: "Wait for completion")
        
        sut.fetchNextPage {
            XCTAssertTrue(Thread.isMainThread)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_fetchNextPage_deliversMappedCharacters() {
        let characters = [makeCharacter(), makeCharacter()]
        let expectedRequest = GetAllCharactersRequest.request(to: baseURL, page: 1)
        let (sut, client) = makeSUT(characters: characters)
        let expectation = self.expectation(description: "Wait for completion")
        
        sut.fetchNextPage {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    
        XCTAssertEqual(client.messages, [.data(expectedRequest)])
        XCTAssertEqual(sut.characters.count, 2)
    }
    
    // MARK: - Helpers
    private func makeSUT(
        characters: [GetAllCharactersMapper.Character] = [],
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (CharacterListViewModel, SpyHTTPClient) {
        let client = SpyHTTPClient(stubbedResponse: charactersStubbedResponse(characters: characters))
        let sut = CharacterListViewModel(client: client, baseURL: baseURL, imageCache: InMemoryImageCache())
        
        trackForMemoryLeaks(client, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, client)
    }
}
