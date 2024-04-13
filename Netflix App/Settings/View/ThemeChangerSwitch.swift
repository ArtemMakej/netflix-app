//
//  ThemeChangerSwitch.swift
//  Netflix App
//
//  Created by Artem Mackei on 04.04.2024.
//

import UIKit

class ThemeChangerSwitch: UIView {
    
    private let panGestureRecognizer = UIPanGestureRecognizer()
    private let redView = UIView()
    private let blueView = UIView()
    private let sliderImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedpanGestureRecognizer() {
        let location = panGestureRecognizer.location(in: self)
        let maxOriginX = self.frame.width - sliderImageView.frame.width - 1.5
        let movingRange = maxOriginX - 1.5
        let redColourPercentange = location.x / movingRange
        guard location.x <= maxOriginX && location.x >= 1.5 else { return }
        sliderImageView.frame.origin.x = location.x
        blueView.alpha = 1 - redColourPercentange
        var theme: InterfaceTheme?
        if redColourPercentange > 0.9 {
            theme = .dark
        } else if redColourPercentange < 0.1 {
            theme = .light
        }
        
        print(redColourPercentange)
        if let theme {
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = theme == .dark ? .dark : .light
        }
        
        print("распечатай \(location)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        redView.frame = self.bounds
        blueView.frame = self.bounds
    }
}

private extension ThemeChangerSwitch {
    
    private func setupViews() {
        self.backgroundColor = .brown
        self.clipsToBounds = true
        panGestureRecognizer.addTarget(self, action: #selector(tappedpanGestureRecognizer))
        sliderImageView.addGestureRecognizer(panGestureRecognizer)
        self.addSubview(redView)
        self.addSubview(blueView)
        self.addSubview(sliderImageView)
        redView.backgroundColor = UIColor(red: 255/255, green: 69/255, blue: 58/255, alpha: 1)
        blueView.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        sliderImageView.backgroundColor = .white
        sliderImageView.isUserInteractionEnabled = true
        sliderImageView.clipsToBounds = true
        sliderImageView.contentMode = .scaleAspectFill
        let sliderImage = UIImage(named: "switch-icon")
        //?.withAlignmentRectInsets(.init(top: 3, left: 3, bottom: 3, right: 3))
        sliderImageView.image = sliderImage
        sliderImageView.frame = .init(x: 1.5, y: 1.5, width: 30, height: 30)
        sliderImageView.layer.cornerRadius = 15
    }
}
