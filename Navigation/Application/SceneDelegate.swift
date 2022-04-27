//
//  SceneDelegate.swift
//  Diplom
//
//  Created by Evgeny Mastepan on 02.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)

        // MARK: - main Start point

        self.window?.rootViewController = UINavigationController(rootViewController: SplashViewController())

        // MARK: - debug Start points:

//        self.window?.rootViewController = UINavigationController(rootViewController: ProfileViewController())

//        self.window?.rootViewController = UINavigationController(rootViewController: PhotosViewController())

        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

