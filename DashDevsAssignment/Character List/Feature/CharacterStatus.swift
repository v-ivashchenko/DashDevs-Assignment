//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import SwiftUI

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
    
    @ViewBuilder
    var background: some View {
        let rectangle = RoundedRectangle(cornerRadius: 25)
        
        switch self {
        case .alive: rectangle.foregroundStyle(Color(uiColor: .lightBlue))
        case .dead: rectangle.foregroundStyle(Color(uiColor: .lightPink))
        case .unknown: rectangle.stroke(Color(uiColor: .lightAccent3))
        }
    }
}
