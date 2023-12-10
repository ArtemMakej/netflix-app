//
//  SeriesCardView.swift
//  Netflix App
//
//  Created by Artem Mackei on 23.11.2023.
//

import UIKit

protocol ISeriesCardView: AnyObject {
func updateView(with tvShowModel: TvShowModel)
}

final class SeriesCardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.dynamicColor(dynamic: .appBackground)
    }
    
    public let presenter: ISeriesCardPresenter

    init(presenter:ISeriesCardPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SeriesCardViewController: ISeriesCardView {
    func updateView(with tvShowModel: TvShowModel) {
    }
}
