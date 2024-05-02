//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

enum Design {
    
    enum Font {
        
        static func latoBold(size: CGFloat = UIFont.labelFontSize) -> UIFont {
            UIFont(name: "Lato-Bold", size: size)!
        }
        
        static func latoRegular(size: CGFloat = UIFont.labelFontSize) -> UIFont {
            UIFont(name: "Lato-Regular", size: size)!
        }
    }
    
    enum Layout {
        
        static let defaultPadding: CGFloat = 20
    }
}
