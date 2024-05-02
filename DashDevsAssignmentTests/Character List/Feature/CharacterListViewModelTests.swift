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
    
    func test_filters_areEmptyOnInit() {
        let (sut, _) = makeSUT()
        
        XCTAssertEqual(sut.filters, [])
    }
    
    func test_fetchFirstPage_deliversMappedCharacters() {
        let result = makeGetAllCharactersResponse(characters: [makeCharacter(), makeCharacter()])
        let json = makeJSON(result.json)
        let expectedRequest = GetAllCharactersRequest.request(to: baseURL)
        let expectedResponse = HTTPURLResponse(statusCode: 200)
        let (sut, client) = makeSUT(stubbedResponse: (json, expectedResponse))
        let expectation = self.expectation(description: "Wait for completion")
        
        sut.fetchFirstPage {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    
        XCTAssertEqual(client.messages, [.data(expectedRequest)])
        XCTAssertEqual(sut.characters.count, 2)
    }
    
    // MARK: - Helpers
    private func makeSUT(
        stubbedResponse: (Data, HTTPURLResponse) = (anyData, anyHTTPResponse),
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (CharacterListViewModel, SpyHTTPClient) {
        let client = SpyHTTPClient(stubbedResponse: stubbedResponse)
        let sut = CharacterListViewModel(client: client, baseURL: baseURL)
        
        trackForMemoryLeaks(client, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, client)
    }
    
    private class SpyHTTPClient: HTTPClient {
        
        enum Message: Equatable {
            case data(URLRequest)
        }
        
        let stubbedResponse: (Data, HTTPURLResponse)
        var messages = [Message]()
        
        init(stubbedResponse: (Data, HTTPURLResponse)) {
            self.stubbedResponse = stubbedResponse
        }
        
        func data(for request: URLRequest) async throws -> (Data, HTTPURLResponse) {
            messages.append(.data(request))
            
            return stubbedResponse
        }
    }
}
