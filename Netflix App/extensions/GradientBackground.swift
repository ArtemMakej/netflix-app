//
//  GradientBackground.swift
//  Netflix App
//
//  Created by Artem Mackei on 27.11.2023.
//

import UIKit

struct GradientBackground {
    static func setup(for view: UIView, gradientLayer: CAGradientLayer, theme: InterfaceTheme) {
        switch theme {
        case .light:
            gradientLayer.colors = [
                UIColor(red: 63/255, green: 155/255, blue: 254/255, alpha: 0.2).cgColor,
                UIColor(red: 83/255, green: 238/255, blue: 39/255, alpha: 0.4).cgColor,
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
