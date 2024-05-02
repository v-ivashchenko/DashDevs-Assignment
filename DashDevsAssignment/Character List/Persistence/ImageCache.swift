//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

protocol ImageCache {
    func image(by path: String) async throws -> UIImage?
    func setImage(_ image: UIImage, by path: String) async throws
}
