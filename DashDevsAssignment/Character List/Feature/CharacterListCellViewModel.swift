//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

struct CharacterListCellViewModel: Equatable {
    
    let id: String
    let name: String
    let species: String
    let imagePath: String
    let status: String
    
    var image: UIImage?
    var imageURL: URL? { .init(string: imagePath) }
}
