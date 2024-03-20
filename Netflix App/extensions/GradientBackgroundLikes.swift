//
//  GradientBackgroundLikes.swift
//  Netflix App
//
//  Created by Artem Mackei on 05.02.2024.
//

import UIKit

enum InterfaceScreenLikes {
   case light
   case dark
}

struct GradientBackgroundLikes {
    
    static func setupViewLikesViewController(for view: UIView, gradientLayer: CAGradientLayer, theme: InterfaceScreenLikes) {
        switch theme {
        case .light:
            gradientLayer.colors = [
                UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1).cgColor,
                UIColor(red: 255/255, green: 103/255, blue: 95/255, alpha: 0).cgColor
                    ]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = view.bounds
    
        case .dark:
            gradientLayer.colors = [
                    UIColor(red: 255/255, green: 69/255, blue: 58/255, alpha: 1).cgColor,
                    UIColor(red: 255/255, green: 103/255, blue: 95/255, alpha: 0).cgColor
            ]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = view.bounds
        }
    }
}
