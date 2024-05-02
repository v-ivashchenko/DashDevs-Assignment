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
    
    func test_image_returnsImageOnNonEmptyCache() async throws {
        let expectedImage1 = anyUIImage
        let expectedImage2 = anyUIImage
        let key1 = UUID().uuidString
        let key2 = UUID().uuidString
        let sut = makeSUT()
        
        try await sut.setImage(expectedImage1, by: key1)
        try await sut.setImage(expectedImage2, by: key2)
        let resultImage1 = try await sut.image(by: key1)
        let resultImage2 = try await sut.image(by: key2)
        
        XCTAssertEqual(resultImage1, expectedImage1)
        XCTAssertEqual(resultImage2, expectedImage2)
    }
    
    // MARK: - Helpers
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> ImageCache {
        let sut = InMemoryImageCache()
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return sut
    }
    
    private var anyUIImage: UIImage { .init(systemName: "plus")! }
}
