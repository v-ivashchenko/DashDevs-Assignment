//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

class InMemoryImageCache: ImageCache {
    
    // MARK: - Private properties
    private let cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.totalCostLimit = 1024 * 1024 * 100
        
        return cache
    }()
    
    func image(by path: String) async throws -> UIImage? {
        cache.object(forKey: path as NSString)
    }
    
    func setImage(_ image: UIImage, by path: String) async throws {
        
    }
}
