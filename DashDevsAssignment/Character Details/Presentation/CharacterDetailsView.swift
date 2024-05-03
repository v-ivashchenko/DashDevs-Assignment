//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import SwiftUI

struct CharacterDetailsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let name: String
    let species: String
    let gender: String
    let status: CharacterStatus
    let location: String
    let image: UIImage?
    
    var body: some View {
        ZStack {
            VStack {
                Group {
                    if let image {
                        Image(uiImage: image)
                            .resizable()
                    } else {
                        Color.gray
                    }
                }
                .aspectRatio(1, contentMode: .fit)
                .clipShape(
                    .rect(
                        topLeadingRadius: 25,
                        bottomLeadingRadius: 50,
                        bottomTrailingRadius: 50,
                        topTrailingRadius: 25
                    )
                )
                .frame(maxWidth: .infinity)
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(name)
                            .font(Design.Font.latoBold(size: 32).toFont)
                        
                        HStack {
                            Text(species)
                            
                            Text("·")
                                .bold()
                            
                            Text(gender)
                                .foregroundStyle(.lightAccent2)
                        }
                        .font(Design.Font.latoRegular(size: 24).toFont)
                        .foregroundStyle(.lightAccent)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(status.title)
                        .padding(10)
                        .background(
                            Capsule()
                                .foregroundStyle(.middleBlue)
                        )
                }
                .padding()
                .padding()
                
                Group {
                    Text("Location: ")
                        .font(Design.Font.latoBold(size: 24).toFont)
                    +
                    Text(location)
                        .font(Design.Font.latoRegular(size: 24).toFont)
                }
                .padding(.horizontal)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .ignoresSafeArea(edges: .top)
            
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .padding()
                    .background(Color(uiColor: .systemBackground))
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)
            })
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .foregroundStyle(.accent)
    }
}

#Preview {
    CharacterDetailsView(
        name: "Zephyr",
        species: "Elf",
        gender: "Male",
        status: .alive,
        location: "Earth",
        image: UIImage(systemName: "photo.circle")
    )
}
