//
//  GradientBackground.swift
//  Netflix App
//
//  Created by Artem Mackei on 27.11.2023.
//

import UIKit

enum InterfaceTheme {
    case light
    case dark
}

struct GradientBackground {
    static func setup(for view: UIView, gradientLayer: CAGradientLayer, theme: InterfaceTheme) {
        switch theme {
        case .light:
            gradientLayer.colors = [
                UIColor(red: 217/255, green: 233/255, blue: 250/255, alpha: 1).cgColor,
                UIColor(red: 206/255, green: 236/255, blue: 218/255, alpha: 1).cgColor,
                UIColor(red: 201/255, green: 245/255, blue: 183/255, alpha: 1).cgColor
            ]
            gradientLayer.locations = [0.0, 0.5, 0.8, 1.0]
            gradientLayer.frame = view.bounds
        case .dark:
            
            let gradientColors: [CGColor] = [
                UIColor(red: 36/255, green: 38/255, blue: 45/255, alpha: 1).cgColor,
                UIColor(red: 39/255, green: 38/255, blue: 46/255, alpha: 1).cgColor,
                UIColor(red: 44/255, green: 38/255, blue: 45/255, alpha: 1).cgColor,
                UIColor(red: 60/255, green: 39/255, blue: 42/255, alpha: 1).cgColor
            ]
            gradientLayer.colors = gradientColors
            gradientLayer.locations = [0.0, 0.80, 0.90,  0.95, 1.0]
            gradientLayer.frame = view.bounds
        }
    }
}
