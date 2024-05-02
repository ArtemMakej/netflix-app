//
//  UIUserInterfaceStyle+Ext.swift
//  Pods
//
//  Created by Ivan Glushko on 16.04.2024.
//

import UIKit

//
extension UIUserInterfaceStyle {
    
    func toInterfaceTheme() -> InterfaceTheme {
        switch self {
        case .dark: return .dark
        default: return .light
        }
    }
    
    init(theme: InterfaceTheme) {
        switch theme {
        case .dark: 
            self = .dark
        case .light: 
            self = .light
        }
    }
}

