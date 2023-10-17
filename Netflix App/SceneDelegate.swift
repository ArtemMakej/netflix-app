//
//  SceneDelegate.swift
//  Netflix App
//
//  Created by Artem Mackei on 03.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let mainAssembly = MainAssembly()
        let mainViewController = mainAssembly.assemble()
        
        let settingsAssembly = SettingsAssembly()
        let settingsViewController = settingsAssembly.assemble()
        
        let likesAssembly = LikesAssembly()
        let likesViewController = likesAssembly.assemble()
        
        let tabBarController = UITabBarController()
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarController
        let tabBarControllers = UITabBarController()
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let mainTabBarItem = UITabBarItem(title: "Главная", image: nil, tag: 1)
        let mainAttribites: [NSAttributedString.Key:Any] =
        [.font:UIFont.boldSystemFont(ofSize: 17),
         .foregroundColor:UIColor.black
        ]
        mainTabBarItem.setTitleTextAttributes(mainAttribites, for: .normal)
        mainViewController.tabBarItem = mainTabBarItem
        
        let likesTabBarItem = UITabBarItem(title: "Любимое", image: nil, tag: 1)
        let likesAttributes: [NSAttributedString.Key:Any] =
        [.font: UIFont.boldSystemFont(ofSize: 17),
         .foregroundColor:UIColor.black
        ]
        likesTabBarItem.setTitleTextAttributes(
            likesAttributes,
            for: .normal)
        likesViewController.tabBarItem = likesTabBarItem
        
        let settingsTabBarItem = UITabBarItem(title: "Настройки", image: nil, tag: 1)
        let settingsAttibutes: [NSAttributedString.Key:Any] = [.font:UIFont.boldSystemFont(ofSize: 17), .foregroundColor:UIColor.black]
        settingsTabBarItem.setTitleTextAttributes(settingsAttibutes, for: .normal)
        settingsViewController.tabBarItem = settingsTabBarItem
        
        tabBarController.viewControllers = [mainViewController, likesViewController, settingsViewController]
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

