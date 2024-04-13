//
//  ThemeChangerView.swift
//  Netflix App
//
//  Created by Artem Mackei on 04.04.2024.
//

import UIKit

class ThemeChangerView: UIView {
    
    private let themeChangerCloudImageView = UIImageView()
    private let themeChangerCloudSwith = ThemeChangerSwitch()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCloud()
        configureSwitch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCloud() {
        self.addSubview(themeChangerCloudImageView)
        self.backgroundColor = .backgroundColour.color
        self.layer.cornerRadius = 42
        themeChangerCloudImageView.clipsToBounds = true
        themeChangerCloudImageView.snp.makeConstraints { maker in
            maker.top.trailing.equalToSuperview().inset(16)
            maker.height.equalTo(52)
            maker.width.equalTo(95)
        }
    
        themeChangerCloudImageView.image = UIImage(named: "cloud")
    }
    
    func configureSwitch() {
        self.addSubview(themeChangerCloudSwith)
        themeChangerCloudSwith.layer.cornerRadius = 15
        themeChangerCloudSwith.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(16)
            maker.centerY.equalToSuperview()
            maker.height.equalTo(33)
            maker.width.equalTo(82.5)
        }
    }
}

extension UIColor {
    static let backgroundColour = Dynamic(
        light: UIColor(red: 214/255, green: 231/255, blue: 253/255, alpha: 1),
        dark: UIColor(red: 35/255, green: 38/255, blue: 46/255, alpha: 1)
    )
}

