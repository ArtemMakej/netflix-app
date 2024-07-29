//
//  LikesViewController.swift
//  Netflix App
//
//  Created by Artem Mackei on 05.10.2023.
//

import UIKit

protocol ILikesView: AnyObject {
    // MARK: - ILikesView
    func reloadData()
    func showEmptyLike(indexPath: IndexPath)
    func showFilledLike(indexPath: IndexPath)
}

final class LikesViewController: UIViewController {
    // MARK: - Properties
    private let presenter: ILikesPresenter
    private let scrollView = UIScrollView()
    private let likeContentView = UIView()
    private let likesView = UIView()
    private let favoritesLabel = UILabel()
    private let counterLabel = UILabel()
    private let favoritesImageView = UIImageView()
    private let gradientLayer = CAGradientLayer()
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionLikesView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Dynamic.appBackground.color
        setupScrollView()
        setuplikeContentView()
        setupNavigationItem()
        setUpViews()
        traitCollectionDidChange(nil)
        updateLikeCounter(.init(name: .likePressed, object: nil))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        switch traitCollection.userInterfaceStyle {
        case .dark:
            GradientBackgroundLikes.setupViewLikesViewController(for: likesView, gradientLayer: gradientLayer, theme: .dark)
        default:
            GradientBackgroundLikes.setupViewLikesViewController(for: likesView, gradientLayer: gradientLayer, theme: .light)
        }
    }
    // MARK: - Init
    init(presenter: ILikesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateLikeCounter), name: .likePressed, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func updateLikeCounter(_ notification: NSNotification) {
        let likeCount = LikedTvShowsService.shared.likedTvShows().count
        counterLabel.text = "\(likeCount)"
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.bounces = false
        scrollView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
    
    private func setupNavigationItem() {
        let navigationTitleColor = UIColor.Dynamic.imageColor.color
        let titleFont = Font.avenir(weight: .bold, size: 17)
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: navigationTitleColor,
            .font: titleFont
        ]
        navigationItem.title = "FAVORITES"
    }
    
    private func setUpViews() {
        collectionLikesView.delegate = self
        collectionLikesView.dataSource = self
        view.addSubview(collectionLikesView)
        collectionLikesView.register(LikesCell.self, forCellWithReuseIdentifier: LikesCell.id)
        flowLayout.minimumLineSpacing = 31
        collectionLikesView.backgroundColor = nil
        collectionLikesView.contentInset = UIEdgeInsets(top: 0, left: 31, bottom: 10, right: 30)
        view.backgroundColor = UIColor.dynamicColor(dynamic: .appBackground)
        collectionLikesView.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.top.equalTo(view.snp.top).inset(306)
            maker.bottom.equalTo(view.snp.bottomMargin)
        }
    }
    
    private func setuplikeContentView() {
        scrollView.addSubview(likeContentView)
        likeContentView.addSubview(likesView)
        likesView.layer.addSublayer(gradientLayer)
        likesView.addSubview(favoritesLabel)
        likesView.addSubview(counterLabel)
        likesView.addSubview(favoritesImageView)
        
        likeContentView.clipsToBounds = true
        likeContentView.snp.makeConstraints { maker in
            maker.width.equalToSuperview()
            maker.height.equalTo(1300)
            maker.edges.equalToSuperview()
        }
        
        likesView.clipsToBounds = true
        likesView.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.equalTo(393)
        }
        
        likesView.setNeedsLayout()
        likesView.layoutIfNeeded()
        favoritesLabel.clipsToBounds = true
        favoritesLabel.numberOfLines = 0
        favoritesLabel.textAlignment = .left
        favoritesLabel.font = Font.avenir(weight: .bold, size: 42)
        favoritesLabel.text = Loc.favoritesLabel
        favoritesLabel.textColor = .white
        favoritesLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(favoritesImageView.snp.bottom)
            maker.right.left.equalToSuperview().inset(31)
            maker.height.equalTo(45)
        }
        
        counterLabel.clipsToBounds = true
        counterLabel.numberOfLines = 0
        counterLabel.textColor = .white
        counterLabel.font = Font.avenir(weight: .bold, size: 32)
        counterLabel.textAlignment = .left
        counterLabel.snp.makeConstraints { maker in
            maker.top.equalTo(135)
            maker.left.equalTo(31)
        }
        
        favoritesImageView.clipsToBounds = true
        let  favoritesImage = UIImage(named: "favorites")?.withRenderingMode(.alwaysTemplate)
        favoritesImageView.tintColor = .white
        favoritesImageView.image = favoritesImage
        favoritesImageView.snp.makeConstraints { maker in
            maker.top.equalTo(31)
            maker.right.equalToSuperview().inset(46)
            maker.width.equalTo(65)
            maker.height.equalTo(91)
        }
    }
}

extension LikesViewController: ILikesView {
    func reloadData() {
        collectionLikesView.reloadData()
    }
    
    func showFilledLike(indexPath: IndexPath) {
        let cell = collectionLikesView.cellForItem(at: indexPath) as? LikesCell
        cell?.tapLikesButton(filled: true)
    }
    
    func showEmptyLike(indexPath: IndexPath) {
        let cell = collectionLikesView.cellForItem(at: indexPath) as? LikesCell
        cell?.tapLikesButton(filled: false)
    }
}

extension Notification.Name {
    static let likePressed = Notification.Name("LikePressed")
}

extension LikesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (150/393) * collectionView.frame.width
        return CGSize(width: width, height: width)
    }
}

extension LikesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellItem = presenter.cell(for: indexPath)
        switch cellItem {
        case let .likeCell(netflixFullModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikesCell.id, for: indexPath) as? LikesCell else { fatalError("no such cell") }
            cell.configure(model: netflixFullModel)
            cell.onLikeTap = { [weak self] in
                self?.presenter.didTapLikeButton(atIndexPath: indexPath)
            }
            cell.tapLikesButton(filled: true)
            return cell
        }
    }
}
