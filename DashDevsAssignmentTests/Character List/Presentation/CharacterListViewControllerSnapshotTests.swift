//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

final class CharacterListViewControllerSnapshotTests: XCTestCase {

    func test_snapshot() {
        let characters = makeCharacters()
        let client = SpyHTTPClient(stubbedResponse: charactersStubbedResponse(characters: characters))
        let viewModel = CharacterListViewModel(client: client, baseURL: baseURL, imageCache: InMemoryImageCache())
        let sut = CharacterListViewController(viewModel: viewModel)
        
        sut.loadViewIfNeeded()
        
        assert(snapshot: sut.snapshot(for: .iPhone15(style: .dark)), named: "CHARACTER_LIST_DARK")
        assert(snapshot: sut.snapshot(for: .iPhone15(style: .light)), named: "CHARACTER_LIST_LIGHT")
    }
    
    // MARK: - Helpers
    private func makeCharacters() -> [SUT.Character] {
        [
            makeCharacter(id: 1, name: "Zephyr", status: "Unknown", species: "Elf", gender: "Male", image: ""),
            makeCharacter(id: 2, name: "Aurora", status: "Alive", species: "Human", gender: "Male", image: ""),
            makeCharacter(id: 3, name: "Thorne", status: "Dead", species: "Dwarf", gender: "Male", image: ""),
            makeCharacter(id: 4, name: "Lyra", status: "Unknown", species: "Faerie", gender: "Male", image: ""),
            makeCharacter(id: 5, name: "Zephyr", status: "Unknown", species: "Elf", gender: "Male", image: ""),
            makeCharacter(id: 6, name: "Aurora", status: "Alive", species: "Human", gender: "Male", image: ""),
            makeCharacter(id: 7, name: "Thorne", status: "Dead", species: "Dwarf", gender: "Male", image: ""),
            makeCharacter(id: 8, name: "Lyra", status: "Unknown", species: "Faerie", gender: "Male", image: "")
        ]
    }
}
