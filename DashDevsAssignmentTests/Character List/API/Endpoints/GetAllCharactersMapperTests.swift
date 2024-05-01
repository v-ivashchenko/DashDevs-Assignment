//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

final class GetAllCharactersMapperTests: XCTestCase {
    
    typealias SUT = GetAllCharactersMapper
    
    func test_map_throwsErrorOnNon200HTTPResponse() {
        let samples = [199, 201, 300, 400, 500]
        
        samples.forEach { code in
            expectToCompleteWith(statusCode: code, expectedError: .invalidStatusCode(code))
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidData() {
        let data = Data("invalid data".utf8)
        
        expectToCompleteWith(data: data, statusCode: 200, expectedError: .invalidData)
    }
    
    func test_map_deliversResultOn200HTTPResponseWithValidData() throws {
        let result = makeResult()
        let json = makeJSON(result.json)
        
        let mappedResponse = try SUT.map(data: json, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(mappedResponse, result.model)
    }
    
    // MARK: - Helpers
    private func expectToCompleteWith(
        data: Data = anyData,
        statusCode: Int,
        expectedError: SUT.Error,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertThrowsError(try SUT.map(data: data, from: HTTPURLResponse(statusCode: statusCode))) { error in
            XCTAssertEqual(error as? SUT.Error, expectedError, file: file, line: line)
        }
    }
    
    private func makeResult() -> (model: SUT.Response, json: [String: Any]) {
        let character1 = makeCharacter()
        let character2 = makeCharacter()
        
        let response = SUT.Response(results: [character1, character2])
        
        let json: [String: Any] = [
            "results": [
                [
                    "id": character1.id,
                    "name": character1.name,
                    "status": character1.status,
                    "species": character1.species,
                    "gender": character1.gender,
                    "image": character1.image
                ],
                [
                    "id": character2.id,
                    "name": character2.name,
                    "status": character2.status,
                    "species": character2.species,
                    "gender": character2.gender,
                    "image": character2.image
                ]
            ]
        ]
        
        return (response, json)
    }
    
    private func makeCharacter(
        id: Int = Int.random(in: 1...100),
        name: String = "any name",
        status: String = "any status",
        species: String = "any species",
        gender: String = "any gender",
        image: String = "any url"
    ) -> SUT.Character {
        .init(id: id, name: name, status: status, species: species, gender: gender, image: image)
    }
}
