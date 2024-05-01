//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import DashDevsAssignment

final class SceneDelegateTests: XCTestCase {
    
    func test_configureWindow_setRootAndMakeKeyAndVisible() {
        let window = WindowSpy()
        let sut = SceneDelegate()
        sut.window = window
        
        sut.configureWindow()
        
        XCTAssertEqual(window.makeKeyAndVisibleCallCount, 1)
    }
    
    func test_configureWindow_setsConcreteRootViewController() {
        let sut = SceneDelegate()
        sut.window = UIWindow()
        
        sut.configureWindow()
        
        let rootViewController = sut.window?.rootViewController
        let rootNavigationController = rootViewController as? UINavigationController
        let topViewController = rootNavigationController?.topViewController
        
        XCTAssertNotNil(rootNavigationController, "Expected a navigation controller as root, got \(String(describing: rootViewController)) instead")
        XCTAssertTrue(topViewController is CharacterListViewController, "Expected a different view controller, got \(String(describing: topViewController)) instead")
    }
    
    // MARK: - Helpers
    private class WindowSpy: UIWindow {
        
        var makeKeyAndVisibleCallCount = 0
        
        override func makeKeyAndVisible() {
            makeKeyAndVisibleCallCount += 1
        }
    }
}
