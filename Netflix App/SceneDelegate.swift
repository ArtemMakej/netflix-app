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
        let mainTabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        mainViewController.tabBarItem = mainTabBarItem
        
        guard let _ = (scene as? UIWindowScene) else { return }
        let likesTabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        likesViewController.tabBarItem = likesTabBarItem
        
        let settingsTabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        settingsViewController.tabBarItem = settingsTabBarItem
        
        tabBarController.viewControllers = [mainViewController, likesViewController, settingsViewController]
    }
}

