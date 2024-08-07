//
//  GradientBackground.swift
//  Netflix App
//
//  Created by Artem Mackei on 27.11.2023.
//

import UIKit

struct GradientBackground {
    
    // MARK: - Static
    
    static func setup(for view: UIView, gradientLayer: CAGradientLayer, theme: InterfaceTheme) {
        switch theme {
        case .light:
            gradientLayer.colors = [
                UIColor(red: 100/255, green: 149/255, blue: 237/255, alpha: 0.2).cgColor,
                UIColor(red: 100/255, green: 149/255, blue: 237/255, alpha: 0.1).cgColor,
                UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
            ]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = view.bounds
        case .dark:
            let gradientColors: [CGColor] = [
                UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.3).cgColor,
                UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.3).cgColor
            ]
            gradientLayer.colors = gradientColors
            gradientLayer.locations = [1.0, 1.0]
            gradientLayer.frame = view.bounds
        }
    }
}
