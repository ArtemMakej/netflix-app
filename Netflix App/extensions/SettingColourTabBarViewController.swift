//
//  SettingColourTabBarViewController.swift
//  Netflix App
//
//  Created by Artem Mackei on 08.02.2024.
//

import UIKit

final class SettingColourTabBarViewController: UITabBarController {
    
    var themeTintColour: UIColor.Dynamic? {
        
        didSet {
            apply(dynamicColor: themeTintColour, theme: traitCollection.userInterfaceStyle)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        apply(dynamicColor: themeTintColour, theme: traitCollection.userInterfaceStyle)
    }
    
    private func apply(dynamicColor: UIColor.Dynamic?, theme: UIUserInterfaceStyle) {
        switch theme {
        case .dark:
           tabBar.tintColor = dynamicColor?.dark
        default:
            tabBar.tintColor = dynamicColor?.light
        }
    }
}
