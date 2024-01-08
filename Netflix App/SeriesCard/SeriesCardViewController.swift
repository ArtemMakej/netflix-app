//
//  SeriesCardView.swift
//  Netflix App
//
//  Created by Artem Mackei on 23.11.2023.
//

import UIKit
import SnapKit

protocol ISeriesCardView: AnyObject {
    func updateView(with tvShowModel: NetflixFull)
}

final class SeriesCardViewController: UIViewController {
    private lazy var screenView = SeriesCardView(frame: view.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        view.backgroundColor = UIColor.dynamicColor(dynamic: .appBackground)
    }
    
    public let presenter: ISeriesCardPresenter
    
    init(presenter: ISeriesCardPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.addSubview(screenView)
        screenView.backgroundColor = .darkGray
        screenView.snp.makeConstraints { maker in
            maker.edges.equalTo(view.safeAreaLayoutGuide)
        }
        screenView.setNeedsLayout()
        screenView.layoutIfNeeded()
    }
}

extension SeriesCardViewController: ISeriesCardView {
    func updateView(with tvShowModel:NetflixFull) {
        screenView.configure(model: tvShowModel)
    }
}

