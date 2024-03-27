//
//  MainViewController.swift
//  Netflix App
//
//  Created by Artem Mackei on 03.10.2023.
//

import SnapKit
import UIKit


protocol IMainView: AnyObject {
    func reloadData()
    func stopRefreshControl()
}

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let presenter: IMainPresenter
    private let refreshControl = UIRefreshControl()
    private var lastContentHeight: CGFloat = 0 as CGFloat
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.dynamicColor(dynamic: .appBackground)
        presenter.viewDidLoad()
        setupNavigationItem()
        setupViews()
    }
    
    init(presenter: IMainPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavigationItem() {
        let navigationTitleColor = UIColor.imageColor.color
        let titleFont = Font.avenir(weight: .bold, size: 17)
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: navigationTitleColor,
            .font: titleFont
        ]
        navigationItem.title = "NETFLIX"
    }
    
    @objc private func refreshData() {
        guard refreshControl.isRefreshing else { return }
        lastContentHeight = 0
        presenter.refreshControlDidStart()
    }
    
    private func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        view.addSubview(collectionView)
        collectionView.register(
            NetflixCell.self,
            forCellWithReuseIdentifier: NetflixCell.id)
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.backgroundColor = nil
        view.backgroundColor = UIColor.dynamicColor(dynamic: .appBackground)
        collectionView.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.top.equalTo(view.snp.topMargin)
            maker.bottom.equalTo(view.snp.bottomMargin)
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            return presenter.numberOfCells()
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cellItem = presenter.cell(for: indexPath)
        switch cellItem {
        case let .tvShow(model):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NetflixCell.id,
                for: indexPath) as? NetflixCell else { fatalError("no such cell") }
            cell.configure(model: model)
            return cell
        }
    }
    
    private func showSeriesCard(for netflixShortModel: NetflixShortModel) {
        let seriesCardAssembly = SeriesCardAssembly()
        let seriesCardViewController = seriesCardAssembly.assemble(id: netflixShortModel.id)
        
        navigationController?.pushViewController(seriesCardViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard case let .tvShow(model) = presenter.cell(for: indexPath) else {
            return
        }
        showSeriesCard(for: model)
    }
}

extension MainViewController: IMainView {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func stopRefreshControl() {
        refreshControl.endRefreshing()
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 232)
        }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.bounds.size.height * 3
        print("offsetY - \(offsetY), contentHeight - \(contentHeight), screenHeight - \(screenHeight)")
        if offsetY > (contentHeight - screenHeight) {
            guard lastContentHeight != scrollView.contentSize.height else { return }
            lastContentHeight = contentHeight
            self.presenter.userDidScrollToPageEnd()
        }
    }
}
