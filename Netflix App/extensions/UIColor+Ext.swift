//
//  UIColour.swift
//  Netflix App
//
//  Created by Artem Mackei on 13.10.2023.
//

import UIKit

extension UIColor {
    
    struct Dynamic {
        let light: UIColor
        let dark: UIColor
        var color: UIColor {
            UIColor.dynamicColor(dynamic: self)
        }
        
        // MARK: - Static
        
        static let appBackground = Dynamic(
            light: .white,
            dark: UIColor(red: 24/255, green: 29/255, blue: 37/255, alpha: 1)
        )
        
        static let textColour = Dynamic(
            light: .black,
            dark: UIColor(
                red: 235/255,
                green: 235/255,
                blue: 245/255,
                alpha: 1)
        )
        
        static let textColourCustom = Dynamic(
            light: .black,
            dark: .white
        )
        
        static let stackViewBackgroundColor = Dynamic(
            light: UIColor(
                red: 239/255,
                green: 246/255,
                blue: 254/255,
                alpha: 1
            ),
            
            dark: UIColor(
                red: 35/255,
                green: 38/255,
                blue: 46/255,
                alpha: 1
            ))
        
        static let backgroundColor = Dynamic(
            light:UIColor(
                red: 239/255,
                green: 246/255,
                blue: 254/255,
                alpha: 1
            ),
            dark: UIColor(
                red: 35/255,
                green: 38/255,
                blue: 46/255,
                alpha: 1
            )
        )
        
        static let tabBarColor = Dynamic(
            light: UIColor(
                red: 52/255,
                green: 120/255,
                blue: 246/255,
                alpha: 1
            ),
            dark: UIColor(
                red: 235/255,
                green: 85/255,
                blue: 69/255,
                alpha: 1
            )
        )
        
        static let imageColor = Dynamic(
            light: UIColor(
                red: 0/255,
                green: 122/255,
                blue: 255/255,
                alpha: 1
            ),
            dark: UIColor(
                red: 255/255,
                green: 69/255,
                blue: 58/255,
                alpha: 1
            )
        )
    }
}

extension UIColor {
    
    // MARK: - Static
    
    static func dynamicColor(dynamic: Dynamic) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(dynamicProvider: {
                $0.userInterfaceStyle == .dark ? dynamic.dark : dynamic.light
            })
        }
        return dynamic.light
    }
}
