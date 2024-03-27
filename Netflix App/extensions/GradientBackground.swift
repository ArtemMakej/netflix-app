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
                UIColor(red: 63/255, green: 155/255, blue: 254/255, alpha: 0.2).cgColor,
                UIColor(red: 83/255, green: 238/255, blue: 39/255, alpha: 0.4).cgColor,
            ]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = view.bounds
        case .dark:
            
            let gradientColors: [CGColor] = [
                UIColor(red: 35/255, green: 38/255, blue: 46/255, alpha: 0).cgColor,
                UIColor(red: 200/255, green: 33/255, blue: 23/255, alpha: 0.2).cgColor,
            ]
            gradientLayer.colors = gradientColors
            gradientLayer.locations = [0.0,  1.0]
            //
            gradientLayer.frame = view.bounds
        }
    }
}
