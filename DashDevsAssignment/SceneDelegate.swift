//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Private properties
    private lazy var navigationController = UINavigationController(rootViewController: rootViewController)
    private lazy var rootViewController = ViewController()
    
    // MARK: - Public properties
    var window: UIWindow?
    
    // MARK: - Public methods
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        configureWindow()
    }
    
    func configureWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
