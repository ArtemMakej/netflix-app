//
//  SettingsPresenter.swift
//  Netflix App
//
//  Created by Artem Mackei on 04.10.2023.
//

import Foundation
    // MARK: - ISettingsPresenter
protocol ISettingsPresenter {
    func viewDidLoad()
    func didTapLinkToWebSite()
    func didTapLinkToEmail()
}

final class SettingsPresenter: ISettingsPresenter {
    // MARK: - Properties
    weak var view: ISettingsView?
    private let email = "artem.makej@bk.ru"
    private let website = "https://github.com/ArtemMakej"
    
    func viewDidLoad() {
        view?.setupView(email: email, website: website)
    }
    
    func didTapLinkToEmail() {
        view?.openEmail(email)
    }
    
    func didTapLinkToWebSite() {
        guard let url = URL(string: website) else { return }
        view?.openSafari(url: url)
    }
}
