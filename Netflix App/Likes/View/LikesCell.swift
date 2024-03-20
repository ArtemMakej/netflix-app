//
//  LikesCell.swift
//  Netflix App
//
//  Created by Artem Mackei on 13.02.2024.
//

import UIKit

final class LikesCell: UICollectionViewCell {
    
    static let id = "LikesCell"
    private let seriesLikeLabel = UILabel()
    private let seriesLikeImageView = UIImageView()
    private let blurLikeImageView = UIImageView()
    private let likeButton = UIButton()
    var onLikeTap: (() -> Void)?
    
    
    private let blurLikeView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .lightGray
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(model: NetflixFull) {
        seriesLikeLabel.text = model.title
        loadLikeImageView(imageURL: model.full_image_url)
    }
    
    func tapLikesButton(filled: Bool) {
        if filled {
            let likeImage = UIImage(named: "likeFilled")?.withRenderingMode(.alwaysTemplate)
            likeButton.setImage(likeImage, for: .normal)
        } else {
            let likeImage = UIImage(named: "likeEmpty")?.withRenderingMode(.alwaysTemplate)
            likeButton.setImage(likeImage, for: .normal)
        }
    }
    
    func setupView() {
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true

        contentView.addSubview(seriesLikeImageView)
        seriesLikeImageView.contentMode = .scaleAspectFill
        seriesLikeImageView.clipsToBounds = true
        seriesLikeImageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
            }
        contentView.addSubview(blurLikeView)
        let blurEffect = UIBlurEffect(style: .light)
        blurLikeView.effect = blurEffect
        blurLikeView.snp.makeConstraints { maker in
            maker.bottom.equalTo(seriesLikeImageView.snp.bottom)
            maker.height.equalTo(40)
            maker.right.left.equalTo(seriesLikeImageView)
        }
        contentView.addSubview(blurLikeImageView)
        blurLikeImageView.clipsToBounds = true
        blurLikeImageView.backgroundColor = .black
        blurLikeImageView.alpha = 0.3
        blurLikeImageView.snp.makeConstraints { maker in
            maker.bottom.equalTo(seriesLikeImageView)
            maker.height.equalTo(40)
            maker.right.left.equalTo(seriesLikeImageView)
        }
        
        blurLikeImageView.addSubview(seriesLikeLabel)
        seriesLikeLabel.textColor = .white
        seriesLikeLabel.numberOfLines = 0
        seriesLikeLabel.textAlignment = .center
        seriesLikeLabel.font = Font.avenir(weight: .regular, size: 12)
            seriesLikeLabel.snp.makeConstraints { maker in
                maker.top.equalTo(blurLikeImageView).inset(1)
                maker.height.equalTo(blurLikeImageView)
                maker.left.equalToSuperview().inset(1)
                maker.right.equalTo(seriesLikeImageView).inset(1)
        }
        contentView.addSubview(likeButton)
        likeButton.addTarget(self, action: #selector(tappedLikeButton), for: .touchUpInside)
        likeButton.tintColor = UIColor.imageColor.color
        likeButton.snp.makeConstraints { maker in
            maker.top.equalTo(seriesLikeImageView).inset(5)
            maker.right.equalTo(seriesLikeImageView).inset(5)
            maker.height.equalTo(22)
            maker.width.equalTo(25)
        }
    }

    @objc func tappedLikeButton() {
        self.onLikeTap?()
    }
    
    private func loadLikeImageView(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async { [weak self] in
                self?.seriesLikeImageView.image = image
            }
        }.resume()
    }
}
