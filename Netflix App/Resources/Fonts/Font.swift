//
//  Font.swift
//  Netflix App
//
//  Created by Artem Mackei on 19.10.2023.
//

import UIKit

struct Font {
    
    enum AvenirWeight {
        case bold
        case regular
        case medium
    }
    
    static func avenir(weight: AvenirWeight = .regular, size: CGFloat) -> UIFont {
        switch weight {
        case .bold:
            return UIFont(name: "Avenir Next Bold", size: size)!
        case .regular:
            return UIFont(name: "Avenir Next Regular", size: size)!
        case .medium:
            return UIFont(name: "Avenir Next Medium", size: size)!
        }
    }
}
