//
//  Copyright © 2024 Vitalii Ivashchenko. All rights reserved.
//

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Private properties
    private let baseURL = URL(string: "https://rickandmortyapi.com")!
    
    private lazy var navigationController = UINavigationController(rootViewController: rootViewController)
    private lazy var rootViewController: CharacterListViewController = {
        let client = URLSessionHTTPClient()
        let imageCache = InMemoryImageCache()
        let viewModel = CharacterListViewModel(client: client, baseURL: baseURL, imageCache: imageCache)
        let viewController = CharacterListViewController(viewModel: viewModel)
        viewController.onSelect = { viewModel in
            let rootView = CharacterDetailsView(
                name: viewModel.name,
                species: viewModel.species,
                gender: "gender",
                status: viewModel.status,
                location: "loc",
                image: viewModel.image
            )
            let hostingController = UIHostingController(rootView: rootView)
            viewController.show(hostingController, sender: viewController)
        }
        
        return viewController
    }()
    
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
