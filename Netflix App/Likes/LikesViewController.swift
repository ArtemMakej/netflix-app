//
//  LikesViewController.swift
//  Netflix App
//
//  Created by Artem Mackei on 05.10.2023.
//

import UIKit

protocol ILikesView: AnyObject {
}

class LikesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .dynamicColor(dynamic: .appBackground)
    }
    
    private let presenter: ILikesPresenter
  
    init(presenter: ILikesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LikesViewController: ILikesView {
    
}

