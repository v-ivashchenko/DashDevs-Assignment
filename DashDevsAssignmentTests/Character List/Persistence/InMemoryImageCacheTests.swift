//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

final class InMemoryImageCacheTests: XCTestCase {

    func test_image_returnsNilOnEmptyCache() async throws {
        let key = UUID().uuidString
        let sut = makeSUT()
        
        let resultImage = try await sut.image(by: key)
        
        XCTAssertNil(resultImage)
    }
    
    // MARK: - Helpers
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> ImageCache {
        let sut = InMemoryImageCache()
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return sut
    }
}
