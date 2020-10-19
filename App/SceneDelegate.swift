//
//  SceneDelegate.swift
//  Images
//
//  Created by Maciek on 19/10/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var appCoordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let windowScene = scene as? UIWindowScene {
            appCoordinator = AppCoordinator(UIWindow(windowScene: windowScene))
            
            appCoordinator?.start()
        }
    }
}
