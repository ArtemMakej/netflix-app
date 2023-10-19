//
//  MainViewController.swift
//  Netflix App
//
//  Created by Artem Mackei on 03.10.2023.
//

import UIKit

protocol IMainView: AnyObject {
    
}

final class MainViewController: UIViewController {
    
    private let presenter: IMainPresenter
    
    init(presenter: IMainPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.viewDidLoad()
    }
}

extension MainViewController: IMainView {
    
}
