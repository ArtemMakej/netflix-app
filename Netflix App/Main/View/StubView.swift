//
//  StubView.swift
//  Netflix App
//
//  Created by Ivan Glushko on 05.08.2024.
//

import UIKit

/// Вью для отображения заглушек
final class StubView: UIView {
    
    private lazy var verticalStackView = UIStackView()
    
    private lazy var imageView = UIImageView()
    private lazy var label = UILabel()
    private lazy var button = UIButton(type: .system)
    private lazy var buttonContainerView = UIView()
    
    private var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(stubData: StubData) {
        setNeedsLayout()
        layoutIfNeeded()
        
        imageView.isHidden = stubData.image == nil
        label.isHidden = stubData.text == nil
        button.isHidden = stubData.buttonText == nil
        
        imageView.image = stubData.image
        label.text = stubData.text
        button.setTitle(stubData.buttonText, for: .normal)
        onTap = stubData.onButtonTap
    }
    
    private func setupViews() {
        addSubview(verticalStackView)
        verticalStackView.axis = .vertical
        verticalStackView.snp.makeConstraints { maker in
            maker.left.top.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(label)
        verticalStackView.addArrangedSubview(buttonContainerView)
        buttonContainerView.addSubview(button)
        verticalStackView.spacing = 10
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { maker in
            maker.height.equalTo(Constants.maxImageHeight)
        }
        
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = Font.avenir(weight: .medium, size: 22)
        
        button.titleLabel?.font = Font.avenir(weight: .regular, size: 17)
        button.tintColor = UIColor.Dynamic.accent.color
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        
        var buttonConfiguration = UIButton.Configuration.bordered()
        buttonConfiguration.background.cornerRadius = 10
        buttonConfiguration.baseBackgroundColor = .gray.withAlphaComponent(0.1)
        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        button.configuration = buttonConfiguration
        button.snp.makeConstraints { maker in
            maker.height.equalToSuperview()
            maker.center.equalToSuperview()
        }
    }
    
    @objc private func didTap() {
        onTap?()
    }
}

private struct Constants {
    static let maxImageHeight: CGFloat = 300
}

struct StubData {
    let image: UIImage?
    let text: String?
    let buttonText: String?
    let onButtonTap: (() -> Void)?
}
