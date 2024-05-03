//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

enum CharacterStatus: String, CaseIterable {
    
    case alive, dead, unknown
    
    init(rawValue: String) {
        self = switch rawValue {
        case "Alive": .alive
        case "Dead": .dead
        default: .unknown
        }
    }
    
    var title: String {
        switch self {
        case .alive: "Alive"
        case .dead: "Dead"
        case .unknown: "Unknown"
        }
    }
}
