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
    
    // MARK: - Helpers
    private func makeSUT() -> (CharacterListViewModel, SpyHTTPClient) {
        let client = SpyHTTPClient()
        let sut = CharacterListViewModel(client: client)
        
        return (sut, client)
    }
    
    private class SpyHTTPClient: HTTPClient {
        
        enum Message {
            case data(URLRequest)
        }
        
        var messages = [Message]()
        
        func data(for request: URLRequest) async throws -> (Data, HTTPURLResponse) {
            messages.append(.data(request))
            
            return (anyData, anyHTTPResponse)
        }
    }
}
