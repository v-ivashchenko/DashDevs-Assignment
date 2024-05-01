//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    
    convenience init(statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
