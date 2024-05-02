//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import SwiftUI

struct CharacterListCellView: View {
    
    let name: String
    let species: String
    let image: UIImage?
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Group {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    ZStack {
                        Color(uiColor: .systemGray5)
                        
                        ProgressView()
                            .controlSize(.large)
                    }
                }
            }
            .frame(width: 100, height: 100)
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
            
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(Design.Font.latoBold(size: 24).toFont)
                    .foregroundStyle(.accent)
                
                Text(species)
                    .font(Design.Font.latoRegular(size: 20).toFont)
                    .foregroundStyle(.lightAccent)
            }
            .padding(.vertical, 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    VStack {
        CharacterListCellView(name: "Zephyr", species: "Elf", image: UIImage(systemName: "photo.circle"))
        CharacterListCellView(name: "Aurora", species: "Human", image: nil)
    }
}
