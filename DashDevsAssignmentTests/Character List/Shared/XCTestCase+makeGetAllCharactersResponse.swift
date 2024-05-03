//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

extension XCTestCase {
    
    typealias SUT = GetAllCharactersMapper
    
    func makeGetAllCharactersResponse(characters: [SUT.Character]) -> (model: SUT.Response, json: [String: Any]) {
        let info = GetAllCharactersMapper.Info(next: nil, prev: nil)
        let response = SUT.Response(info: info, results: characters)
        
        let json: [String: Any] = [
            "info": [
                "next": nil,
                "prev": nil
            ],
            "results": characters.map { character in
                [
                    "id": character.id,
                    "name": character.name,
                    "status": character.status,
                    "species": character.species,
                    "gender": character.gender,
                    "image": character.image,
                    "location": [
                        "name": character.location.name
                    ]
                ] as [String: Any]
            }
        ]
        
        return (response, json)
    }
    
    func makeCharacter(
        id: Int = Int.random(in: 1...100),
        name: String = "any name",
        status: String = "any status",
        species: String = "any species",
        gender: String = "any gender",
        image: String = "any url",
        location: String = "any location"
    ) -> SUT.Character {
        .init(
            id: id,
            name: name,
            status: status,
            species: species,
            gender: gender,
            image: image,
            location: .init(name: location)
        )
    }
}
