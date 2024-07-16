//
//  SettingsViewController.swift
//  Netflix App
//
//  Created by Artem Mackei on 04.10.2023.
//

import UIKit
import SafariServices
import MessageUI

// MARK: - ISettingsView
protocol ISettingsView: AnyObject {
    func setupNavigationItem()
    func setupView(email: String, website: String)
    func openSafari(url: URL)
    func openEmail(_ email: String)
}

final class SettingsViewController: UIViewController {
    // MARK: - Properties
    private let generalStackCoverView = UIView()
    private let aboutStackCoverView = UIView()
    private let settingContentView = UIView()
    private let avatarImageView = UIImageView()
    private let createAvatarButton = UIButton()
    private let generalTitleStackView = UIStackView()
    private let generalTitleLabel = UILabel()
    private let languageInfoStackView = UIStackView()
    private let languageInfoLabel = UILabel()
    private let languageNameLabel = UILabel()
    private let themeScreenStackView = UIStackView()
    private let themesScreenLabel = UILabel()
    private let themeChangerView = ThemeChangerView()
    private let appTitleStackView = UIStackView()
    private let aboutAppLabel = UILabel()
    private let developerInfoStackView = UIStackView()
    private let developerInfoLabel = UILabel()
    private let developerFullNameLabel = UILabel()
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
    private lazy var aboutAppStackView = UIStackView(arrangedSubviews: [
        appTitleStackView,
        developerInfoStackView,
        emailInfoStackView,
        websiteInfoStackView,
        versionAppStackView
    ])
    private lazy var generalStackView = UIStackView(arrangedSubviews: [
        generalTitleStackView,
        languageInfoStackView,
        themeScreenStackView
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
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
        let navigationTitleColor = UIColor.Dynamic.imageColor.color
        let titleFont = Font.avenir(weight: .bold, size: 17)
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: navigationTitleColor,
            .font: titleFont
        ]
        navigationItem.title = "NETFLIX"
    }
    
    func setupView(email: String, website: String) {
        view.backgroundColor = UIColor.Dynamic.appBackground.color
        configure()
        setupNavigationItem()
        сonfigurationGeneralStackView()
        сonfigurationAboutAppStackView(email: email, website: website)
    }
    
    func openSafari(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
    
    func openEmail(_ email: String) {
        guard MFMailComposeViewController.canSendMail()
        else {
            print("Mail services are not available")
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.setToRecipients([email])
        composeVC.setSubject("Netflix App")
        composeVC.setMessageBody("Hello, Artem!", isHTML: false)
        self.present(composeVC, animated: true, completion: nil)
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
        view.addSubview(generalStackCoverView)
        view.addSubview(generalStackView)
        generalStackView.spacing = 16
        generalStackView.axis = .vertical
        generalStackView.distribution = .fill
        generalStackView.backgroundColor = UIColor.Dynamic.stackViewBackgroundColor.color
        generalStackView.snp.makeConstraints { maker in
            maker.top.equalTo(generalStackCoverView).offset(16)
            maker.left.right.equalTo(generalStackCoverView).inset(16)
        }
        
        generalStackCoverView.layer.cornerRadius = 20
        generalStackCoverView.backgroundColor = generalStackView.backgroundColor
        generalStackCoverView.snp.makeConstraints { maker in
            maker.top.equalTo(createAvatarButton.snp.bottom).offset(28)
            maker.leading.trailing.equalToSuperview().inset(25)
            maker.bottom.greaterThanOrEqualTo(generalStackView).offset(23)
        }
        
        generalTitleStackView.axis = .horizontal
        generalTitleStackView.addArrangedSubview(generalTitleLabel)
        generalTitleLabel.text = "Общие"
        generalTitleLabel.font = Font.avenir(weight: .bold, size: 17)
        
        languageInfoStackView.axis = .horizontal
        languageInfoStackView.spacing = 20
        languageInfoStackView.distribution = .fill
        languageInfoStackView.addArrangedSubview(languageInfoLabel)
        languageInfoLabel.text = "Язык"
        languageInfoLabel.font = Font.avenir(weight: .regular, size: 14)
        
        languageInfoStackView.addArrangedSubview(languageNameLabel)
        languageNameLabel.text = "Русский🔎"
        languageNameLabel.font = Font.avenir(weight: .regular, size: 14)
        
        themeScreenStackView.axis = .horizontal
        themeScreenStackView.distribution = .fill
        themeScreenStackView.addArrangedSubview(themesScreenLabel)
        themeScreenStackView.addArrangedSubview(themeChangerView)
        themesScreenLabel.text = "Тема"
        themesScreenLabel.font = Font.avenir(weight: .regular, size: 14)
        themeChangerView.snp.makeConstraints { maker in
            maker.width.equalTo(226)
            maker.height.equalTo(84)
        }
    }
    
    func сonfigurationAboutAppStackView(email: String, website: String) {
        view.addSubview(aboutStackCoverView)
        view.addSubview(aboutAppStackView)
        aboutStackCoverView.layer.cornerRadius = 20
        aboutStackCoverView.backgroundColor = UIColor.Dynamic.stackViewBackgroundColor.color
        aboutAppStackView.spacing = 16
        aboutAppStackView.distribution = .fill
        aboutAppStackView.layer.cornerRadius = 20
        aboutAppStackView.axis = .vertical
        aboutStackCoverView.snp.makeConstraints { maker in
            maker.top.equalTo(generalStackCoverView.snp.bottom).offset(32)
            maker.leading.trailing.equalToSuperview().inset(16)
            maker.bottom.greaterThanOrEqualTo(aboutAppStackView).offset(16)
        }
        
        aboutAppStackView.snp.makeConstraints { maker in
            maker.top.equalTo(aboutStackCoverView).offset(16)
            maker.left.right.equalTo(aboutStackCoverView).inset(16)
        }
        
        appTitleStackView.axis = .horizontal
        appTitleStackView.addArrangedSubview(aboutAppLabel)
        aboutAppLabel.text = "О приложении"
        aboutAppLabel.font = Font.avenir(weight: .bold, size: 17)
        
        developerInfoStackView.axis = .horizontal
        developerInfoStackView.spacing = 20
        developerInfoStackView.addArrangedSubview(developerInfoLabel)
        developerInfoLabel.text = "Разработчик"
        developerInfoLabel.font = Font.avenir(weight: .regular, size: 14)
        
        developerInfoStackView.addArrangedSubview(developerFullNameLabel)
        developerFullNameLabel.text = "Макей Артём"
        developerFullNameLabel.font = Font.avenir(weight: .regular, size: 14)
        
        emailInfoStackView.axis = .horizontal
        emailInfoStackView.spacing = 20
        emailInfoStackView.addArrangedSubview(emailLabel)
        emailLabel.text = "Email"
        emailLabel.font = Font.avenir(weight: .regular, size: 14)
        
        emailInfoStackView.addArrangedSubview(linktoEmailLabel)
        linktoEmailLabel.textColor =  UIColor(red: 44/255, green: 101/255, blue: 208/255, alpha: 1)
        linktoEmailLabel.text = email
        linktoEmailLabel.font = Font.avenir(weight: .regular, size: 14)
        let linktoEmail = UITapGestureRecognizer(target: self, action: #selector(tappedlinktoEmail))
        linktoEmailLabel.addGestureRecognizer(linktoEmail)
        linktoEmailLabel.isUserInteractionEnabled = true
        
        websiteInfoStackView.spacing = 20
        websiteInfoStackView.axis = .horizontal
        websiteInfoStackView.addArrangedSubview(websiteInfoLabel)
        websiteInfoLabel.text = "Website"
        websiteInfoLabel.font = Font.avenir(weight: .regular, size: 14)
        
        websiteInfoStackView.addArrangedSubview(linkToWebsiteLabel)
        linkToWebsiteLabel.textColor = UIColor(red: 44/255, green: 101/255, blue: 208/255, alpha: 1)
        linkToWebsiteLabel.text = website
        linkToWebsiteLabel.font = Font.avenir(weight: .regular, size: 14)
        let linkToWebsite = UITapGestureRecognizer(target: self, action: #selector(tappedLinkToWebsite))
        linkToWebsiteLabel.addGestureRecognizer(linkToWebsite)
        linkToWebsiteLabel.isUserInteractionEnabled = true
        
        versionAppStackView.axis = .horizontal
        versionAppStackView.spacing = 20
        versionAppStackView.addArrangedSubview(versionAppLabel)
        versionAppLabel.text = "Version"
        versionAppLabel.font = Font.avenir(weight: .regular, size: 14)
        versionAppStackView.addArrangedSubview(numberVersionLabel)
        
        numberVersionLabel.text = "1.0.0"
        numberVersionLabel.font = Font.avenir(weight: .regular, size: 14)
    }
    
    @objc func tappedlinktoEmail() {
        presenter.didTapLinkToEmail()
    }
    
    @objc func tappedLinkToWebsite() {
        presenter.didTapLinkToWebSite()
    }
}
