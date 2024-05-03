//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import SwiftUI

struct CharacterListFilterButtonView: View {
    
    let text: String
    var isActive: Bool = true
    let action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text(text)
                .font(Design.Font.latoBold().toFont)
                .foregroundStyle(isActive ? .accent : .gray)
                .padding(10)
                .overlay {
                    Capsule()
                        .stroke(.lightAccent3)
                }
        }
    }
}

#Preview {
    HStack {
        CharacterListFilterButtonView(text: "Alive", action: nil)
        CharacterListFilterButtonView(text: "Dead", action: nil)
        CharacterListFilterButtonView(text: "Unknown", action: nil)
    }
}
