//
//  SettingsViewController.swift
//  Netflix App
//
//  Created by Artem Mackei on 04.10.2023.
//

import UIKit

protocol ISettingsView: AnyObject {
    func setupNavigationItem()
}

final class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    private let settingContentView = UIView()
    private let avatarImageView = UIImageView()
    private let createAvatarButton = UIButton()
    
    private lazy var generalStackView = UIStackView(arrangedSubviews: [
        generalTitleStackView,
        languageInfoStackView,
        themeScreenStackView,
        changeThemeScreenStackView
    ])
    private let generalTitleStackView = UIStackView()
    private let generalTitleLabel = UILabel()
    private let languageInfoStackView = UIStackView()
    private let languageInfoLabel = UILabel()
    private let languageNameLabel = UILabel()
    private let themeScreenStackView = UIStackView()
    private let themesScreenLabel = UILabel()
    private let changeThemeScreenStackView = UIStackView()
    private let changeThemeSwitch = UISwitch()
    private let changeThemeButton = UIButton()
    
    private lazy var aboutAppStackView = UIStackView(arrangedSubviews: [
        appTitleStackView,
        developerInfoStackView,
        emailInfoStackView,
        websiteInfoStackView,
        versionAppStackView
    ])
    
    private let appTitleStackView = UIStackView()
    private let aboutAppLabel = UILabel()
    private let developerInfoStackView = UIStackView()
    private let developerInfoLabel = UILabel()
    private let fullDeveloperNameLabel = UILabel()
    private let emailInfoStackView = UIStackView()
    private let emailLabel = UILabel()
    private let linktoEmailLabel = UILabel()
    private let websiteInfoStackView = UIStackView()
    private let websiteInfoLabel = UILabel()
    private let linkToWebsiteLabel = UILabel()
    private let versionAppStackView = UIStackView()
    private let versionAppLabel = UILabel()
    private let numberVersionLabel = UILabel()

    private let presenter: ISettingsPresenter
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Dynamic.appBackground.color
        presenter.viewDidLoad()
        configure()
        setupNavigationItem()
        сonfigurationGeneralStackView()
        сonfigurationAboutAppStackView()
    }
    
    // MARK: - Init
    init(presenter: ISettingsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsViewController: ISettingsView {
    func setupNavigationItem() {
        let navigationTitleColor = UIColor.imageColor.color
        let titleFont = Font.avenir(weight: .bold, size: 17)
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: navigationTitleColor,
            .font: titleFont
        ]
        navigationItem.title = "NETFLIX"
    }
}
extension SettingsViewController {
    func configure() {
        view.addSubview(settingContentView)
        settingContentView.clipsToBounds = true
        settingContentView.snp.makeConstraints { maker in
            maker.top.equalTo(98)
            maker.left.right.equalToSuperview().inset(9)
            maker.bottom.equalToSuperview().inset(87)
        }
        
        settingContentView.addSubview(createAvatarButton)
        createAvatarButton.clipsToBounds = true
        createAvatarButton.contentMode = .scaleAspectFill
        let createAvatar = UIImage(named: "createAvatar")
        createAvatarButton.setImage(createAvatar, for: .normal)
        createAvatarButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(settingContentView).inset(50)
            maker.height.width.equalTo(100)
        }
        settingContentView.addSubview(avatarImageView)
        avatarImageView.clipsToBounds = true
        let avatar = UIImage(named: "avatar")
        avatarImageView.image = avatar
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.snp.makeConstraints { maker in
            maker.top.equalTo(createAvatarButton.snp.bottom).offset(-20)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(22)
            maker.width.equalTo(24)
        }
    }
}

private extension SettingsViewController {
    
    func сonfigurationGeneralStackView() {
        
        view.addSubview(generalStackView)
        generalStackView.layer.cornerRadius = 20
        generalStackView.axis = .vertical
        generalStackView.backgroundColor = UIColor.Dynamic.stackViewBackgroundColor.color
        generalStackView.snp.makeConstraints { maker in
            maker.top.equalTo(createAvatarButton.snp.bottom).offset(28)
            maker.leading.trailing.equalToSuperview().inset(25)
            maker.height.equalTo(193)
        }
        generalTitleStackView.axis = .horizontal
        generalTitleStackView.addArrangedSubview(generalTitleLabel)
        generalTitleLabel.text = "Общие"
        generalTitleLabel.font = Font.avenir(weight: .bold, size: 22)
        languageInfoStackView.axis = .horizontal
        languageInfoStackView.addArrangedSubview(languageInfoLabel)
        languageInfoLabel.text = "Язык"
        languageInfoLabel.font = Font.avenir(weight: .regular, size: 22)
        languageInfoStackView.addArrangedSubview(languageNameLabel)
        languageNameLabel.text = "Русский"
        languageNameLabel.font = Font.avenir(weight: .regular, size: 22)
        themeScreenStackView.axis = .horizontal
        themeScreenStackView.addArrangedSubview(themesScreenLabel)
        themesScreenLabel.text = "Тема"
        themesScreenLabel.font = Font.avenir(weight: .regular, size: 22)
        changeThemeScreenStackView.axis = .horizontal
        changeThemeScreenStackView.layer.cornerRadius = 20
        changeThemeScreenStackView.backgroundColor = UIColor(red: 214/255, green: 231/255, blue: 253/255, alpha: 1)
        changeThemeScreenStackView.addArrangedSubview(changeThemeSwitch)
        changeThemeScreenStackView.addArrangedSubview(changeThemeButton)
        
    }
    
    func сonfigurationAboutAppStackView() {
        view.addSubview(aboutAppStackView)
        aboutAppStackView.layer.cornerRadius = 20
        aboutAppStackView.axis = .vertical
        aboutAppStackView.backgroundColor = UIColor.Dynamic.stackViewBackgroundColor.color
        aboutAppStackView.snp.makeConstraints { maker in
                maker.top.equalTo(generalStackView.snp.bottom).offset(25)
                maker.leading.trailing.equalToSuperview().inset(25)
                maker.height.equalTo(193)
        }
    }
}
