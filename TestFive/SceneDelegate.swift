//
//  SceneDelegate.swift
//  TestFive
//
//  Created by Dr.Alexandr on 23.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: ApplicationCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {return}
        let appWindow = UIWindow(windowScene: windowScene)
        let navController = UINavigationController()
        appCoordinator = ApplicationCoordinator(router: Router(rootController: navController))
        appCoordinator?.start()
        appWindow.rootViewController = navController
        appWindow.makeKeyAndVisible()
        window = appWindow
    }
}

