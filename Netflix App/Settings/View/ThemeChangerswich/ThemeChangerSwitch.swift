//
//  ThemeChangerSwitch.swift
//  Netflix App
//
//  Created by Artem Mackei on 04.04.2024.
//

import UIKit
    // MARK: - IThemeChangerSwitchView
protocol IThemeChangerSwitchView: AnyObject {
    func set(position: HorizontalPosition)
}

final class ThemeChangerSwitch: UIView, IThemeChangerSwitchView {
    // MARK: - Properties
    private let presenter: IThemeChangerSwitchPresenter
    private let redView = UIView()
    private let blueView = UIView()
    private let sliderImageView = UIImageView()
    private static let sliderInset: CGFloat = 1.5
    private let panGestureRecognizer = UIPanGestureRecognizer()
    private let snapsToSides = true
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    private var position: HorizontalPosition = .left
    
    override func layoutSubviews() {
        super.layoutSubviews()
        redView.frame = self.bounds
        blueView.frame = self.bounds
        presenter.viewLayotSubviews()
    }
    // MARK: - Init
    init(presenter: IThemeChangerSwitchPresenter) {
        self.presenter = presenter
        super.init(frame: .zero)
        setupViews()
        setupSliderImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(position: HorizontalPosition) {
        let leftLimitX = Self.sliderInset
        let rightLimitX = self.frame.width - sliderImageView.frame.width - Self.sliderInset
        var x: CGFloat = position == .left ? leftLimitX : rightLimitX
        x = x + (sliderImageView.frame.width / 2)
        let location: CGPoint = CGPoint(x: x, y: 0)
        updateSliderPosition(location: location)
    }
}

extension ThemeChangerSwitch {
    
    private func setupViews() {
        self.backgroundColor = .brown
        self.clipsToBounds = true
        self.addSubview(redView)
        self.addSubview(blueView)
        self.addSubview(sliderImageView)
        redView.backgroundColor = UIColor(red: 255/255, green: 69/255, blue: 58/255, alpha: 1)
        blueView.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
    }
    
    private func setupSliderImageView() {
        self.addSubview(sliderImageView)
        sliderImageView.clipsToBounds = true
        sliderImageView.backgroundColor = .white
        sliderImageView.image = UIImage(named: "switch-slider")
        sliderImageView.contentMode = .scaleAspectFill
        sliderImageView.isUserInteractionEnabled = true
        let sliderSize = 30 as CGFloat
        sliderImageView.frame = CGRect(x: Self.sliderInset, y: Self.sliderInset, width: sliderSize, height: sliderSize)
        sliderImageView.layer.cornerRadius = sliderSize / 2
        panGestureRecognizer.addTarget(self, action: #selector(handlePanGestureRecognizer))
        sliderImageView.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func updateSliderPosition(location: CGPoint) {
        var location = location
        location.x = location.x - (sliderImageView.frame.width / 2)
        let leftLimitX = Self.sliderInset
        let rightLimitX = self.frame.width - sliderImageView.frame.width - Self.sliderInset
        
        if location.x < leftLimitX {
            location.x = leftLimitX
        } else if location.x > rightLimitX {
            location.x = rightLimitX
        }
        
        let centerX = (self.frame.width / 2) - (sliderImageView.frame.width / 2)
        sliderImageView.frame.origin.x = location.x
        updateSwitchBackground(location: location, leftLimitX: leftLimitX, rightLimitX: rightLimitX)
        updateSwitchForChangeTheme(location: location, leftLimitX: leftLimitX, rightLimitX: rightLimitX, centerSliderX: centerX)
        snapToSide(location: location, leftLimitX: leftLimitX, rightLimitX: rightLimitX, centerSliderX: centerX)
    }
    
    @objc func handlePanGestureRecognizer(sender: UIPanGestureRecognizer) {
        let location = panGestureRecognizer.location(in: self)
        let velocityX = abs(sender.velocity(in: self).x)
        if (0...100).contains(velocityX)  {
            feedbackGenerator.impactOccurred(intensity: velocityX / 100)
        }
        updateSliderPosition(location: location)
    }
}

extension ThemeChangerSwitch {
    
    private func updateSwitchBackground(location: CGPoint, leftLimitX: CGFloat, rightLimitX: CGFloat) {
        let widthMovingSlider = rightLimitX - leftLimitX
        let movingPercentange = location.x / widthMovingSlider
        self.blueView.alpha = 1 - movingPercentange
    }
    
    private func snapToSide(location: CGPoint, leftLimitX: CGFloat, rightLimitX: CGFloat, centerSliderX: CGFloat) {
        guard panGestureRecognizer.state == .ended && snapsToSides else { return }
        UIView.animate(withDuration: 0.2) { [weak self] in
            if location.x > centerSliderX {
                self?.sliderImageView.frame.origin.x = rightLimitX
                self?.updateSwitchBackground(location: CGPoint(x: rightLimitX, y: 0), leftLimitX: leftLimitX, rightLimitX: rightLimitX)
            } else {
                self?.sliderImageView.frame.origin.x = leftLimitX
                self?.updateSwitchBackground(location: CGPoint(x: leftLimitX, y: 0), leftLimitX: leftLimitX, rightLimitX: rightLimitX)
            }
        }
    }
    
    private func updateSwitchForChangeTheme(location: CGPoint, leftLimitX: CGFloat, rightLimitX: CGFloat, centerSliderX: CGFloat) {
        let newPosition: HorizontalPosition = location.x > centerSliderX ? .right : .left
        guard self.position != newPosition else { return }
        self.position = newPosition
        presenter.switchMovedTo(position: newPosition)
    }
}
