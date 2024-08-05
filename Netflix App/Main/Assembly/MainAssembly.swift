//
//  MainAssembly.swift
//  Netflix App
//
//  Created by Artem Mackei on 04.10.2023.
//

import UIKit

// MARK: - IMainAssembly

protocol IMainAssembly {
    func assemble(netflixNetworkAssembly: INetflixNetworkAssembly) -> UIViewController
}

final class MainAssembly: IMainAssembly {
    
    func assemble(netflixNetworkAssembly: INetflixNetworkAssembly) -> UIViewController {
        let netflixService = netflixNetworkAssembly.assembleNetflixService()
        let presenter = MainPresenter(netflixService: netflixService, mainQueue: .main)
        let viewcontroller = MainViewController(presenter:presenter)
        presenter.view = viewcontroller
        return viewcontroller
    }
}
