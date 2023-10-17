//
//  MainViewController.swift
//  Netflix App
//
//  Created by Artem Mackei on 03.10.2023.
//

import SnapKit
import UIKit

protocol IMainView: AnyObject {
}

class MainViewController: UIViewController {
    
    let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let presenter: IMainPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.viewDidLoad()
        setupViews()
    }
    
    init(presenter: IMainPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        let labelTitle = UILabel()
        view.addSubview(labelTitle)
        labelTitle.text = "NETFLIX"
        labelTitle.font = UIFont.boldSystemFont(ofSize: 20)
        labelTitle.textColor = UIColor(red: 181/255, green: 69/255, blue: 60/255, alpha: 1)
        labelTitle.textAlignment = .center
        labelTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(50)
            make.right.equalToSuperview().inset(50)
            make.top.equalToSuperview().inset(50)
            make.height.equalTo(100)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.register(NetflixCell.self, forCellWithReuseIdentifier: NetflixCell.id)
        //настройка коллекции
        collectionView.backgroundColor = UIColor(red: 36/255, green: 38/255, blue: 45/255, alpha: 1)
        collectionView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(50)
            maker.right.equalToSuperview().inset(50)
            maker.top.equalTo(labelTitle).inset(100)
            maker.height.equalTo(200)
        }
    }
}

extension MainViewController: IMainView, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellItem = presenter.cell(for: indexPath)
        switch cellItem {
        case let .tvShow(model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NetflixCell.id, for: indexPath) as? NetflixCell else { fatalError("no such cell") }
            cell.configure(model: model)
            return cell
        }
    }
}

