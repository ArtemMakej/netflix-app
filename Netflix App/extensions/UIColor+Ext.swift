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

        var oppositeColor: UIColor {
            UIColor.getOppositeColor(dynamic: self)
        }

        // MARK: - Static

        static let basic = Dynamic(light: .black, dark: .white)
        static let appBackground = Dynamic(
            light: .white,
            dark: UIColor(red: 24/255, green: 29/255, blue: 37/255, alpha: 1)
        )
    }
}

extension UIColor {

    static func dynamicColor(dynamic: Dynamic) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(dynamicProvider: {
                $0.userInterfaceStyle == .dark ? dynamic.dark : dynamic.light
            })
        }
        return dynamic.light
    }

    static func getOppositeColor(dynamic: Dynamic) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(dynamicProvider: {
                $0.userInterfaceStyle == .dark ? dynamic.light : dynamic.dark
            })
        }
        return dynamic.dark
    }
}

