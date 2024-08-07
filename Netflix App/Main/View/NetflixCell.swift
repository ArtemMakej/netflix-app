//
//  NetflixCell.swift
//  Netflix App
//
//  Created by Artem Mackei on 11.10.2023.
//

import UIKit

final class NetflixCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let id = "NetflixCell"
    private let baseView = UIView()
    private let seriesNameImageView = UIImageView()
    private let seriesDateImageView = UIImageView()
    private let seriesGenreImageView = UIImageView()
    private let seriesImageView = UIImageView()
    private let seriesNameLabel = UILabel()
    private let seriesDateLabel = UILabel()
    private let seriesGenreLabel = UILabel()
    private let gradientLayer = CAGradientLayer()
    
    override func prepareForReuse() {
        seriesNameImageView.image = nil
        seriesDateImageView.image = nil
        seriesGenreImageView.image = nil
        seriesImageView.image = nil
        seriesNameLabel.text = nil
        seriesDateLabel.text = nil
        seriesGenreLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseView.layoutIfNeeded()
        baseView.layer.insertSublayer(gradientLayer, at: 0)
        switch traitCollection.userInterfaceStyle {
        case .dark:
            print("Dark")
            GradientBackground.setup(for: baseView, gradientLayer: gradientLayer, theme: .dark)
        default:
            print("Light")
            GradientBackground.setup(for: baseView, gradientLayer: gradientLayer, theme: .light)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        switch traitCollection.userInterfaceStyle {
        case .dark:
            print("Dark")
            GradientBackground.setup(for: baseView, gradientLayer: gradientLayer, theme: .dark)
        default:
            print("Light")
            GradientBackground.setup(for: baseView, gradientLayer: gradientLayer, theme: .light)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: NetflixShortModel) {
        seriesNameLabel.text = model.title
        let more = model.more
        let separetedMore = more.components(separatedBy: [","])
        let newDate = separetedMore[0]
        let newInfo = separetedMore[1...]
        seriesDateLabel.text = newDate
        seriesGenreLabel.text = Array(newInfo).joined(separator: ",")
    }
    
    func set(image: UIImage?) {
        seriesImageView.image = image
    }
    
    private func setupViews() {
        contentView.addSubview(baseView)
        baseView.addSubview(seriesNameLabel)
        baseView.addSubview(seriesImageView)
        baseView.addSubview(seriesNameImageView)
        baseView.addSubview(seriesDateImageView)
        baseView.addSubview(seriesGenreImageView)
        baseView.addSubview(seriesGenreLabel)
        baseView.clipsToBounds = true
        baseView.layer.cornerRadius = 8
        baseView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        }
        
        seriesNameImageView.clipsToBounds = true
        let nameImage = UIImage(named: "nameSeries")?.withRenderingMode(.alwaysTemplate)
        seriesNameImageView.image = nameImage
        seriesNameImageView.tintColor = UIColor.Dynamic.imageColor.color
        seriesNameImageView.snp.makeConstraints { maker in
            maker.left.equalTo(seriesImageView.snp.right).offset(16)
            maker.top.equalTo(seriesImageView).offset(42)
            maker.height.equalTo(22)
            maker.width.equalTo(22)
        }
        
        seriesDateImageView.clipsToBounds = true
        let dateImage = UIImage(named: "SeriesDate")?.withRenderingMode(.alwaysTemplate)
        seriesDateImageView.image = dateImage
        seriesDateImageView.tintColor = UIColor.Dynamic.imageColor.color
        seriesDateImageView.snp.makeConstraints { maker in
            maker.left.equalTo(seriesImageView.snp.right).offset(16)
            maker.top.equalTo(seriesNameImageView.snp.bottom).offset(8)
            maker.height.equalTo(22)
            maker.width.equalTo(22)
        }
        
        seriesGenreImageView.clipsToBounds = true
        let genreImage = UIImage(named: "SeriesGenre")?.withRenderingMode(.alwaysTemplate)
        seriesGenreImageView.image = genreImage
        seriesGenreImageView.tintColor = UIColor.Dynamic.imageColor.color
        seriesGenreImageView.snp.makeConstraints { maker in
            maker.left.equalTo(seriesImageView.snp.right).offset(16)
            maker.top.equalTo(seriesDateImageView.snp.bottom).offset(8)
            maker.height.equalTo(22)
            maker.width.equalTo(22)
        }
        
        seriesImageView.contentMode = .scaleAspectFill
        seriesImageView.layer.shadowColor = UIColor.black.cgColor
        seriesImageView.layer.shadowOpacity = 0.5
        seriesImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        seriesImageView.layer.shadowRadius = 5.0
        seriesImageView.layer.masksToBounds = false
        seriesImageView.layer.cornerRadius = 8
        seriesImageView.clipsToBounds =  true
        seriesImageView.backgroundColor = .lightGray
        seriesImageView.snp.makeConstraints { maker in
            maker.left.top.equalTo(baseView)
            maker.height.equalToSuperview()
            maker.width.equalTo(160)
        }
        
        seriesNameLabel.clipsToBounds = true
        seriesNameLabel.textAlignment = .left
        seriesNameLabel.textColor = .dynamicColor(dynamic: .textColourCustom)
        seriesNameLabel.font = Font.avenir(weight: .bold, size: 12)
        seriesNameLabel.adjustsFontForContentSizeCategory = true
        seriesNameLabel.numberOfLines = 3
        seriesNameLabel.snp.makeConstraints { maker in
            maker.left.equalTo(seriesImageView.snp.right).offset(46)
            maker.right.equalToSuperview()
            maker.bottom.equalTo(seriesNameImageView)
        }
        
        baseView.addSubview(seriesDateLabel)
        clipsToBounds = true
        seriesDateLabel.textAlignment = .left
        seriesDateLabel.font = Font.avenir(weight: .medium, size: 10)
        seriesDateLabel.textColor = .dynamicColor(dynamic: .textColour)
        seriesDateLabel.snp.makeConstraints { maker in
            maker.left.equalTo(seriesImageView.snp.right).offset(46)
            maker.right.equalToSuperview()
            maker.centerY.equalTo(seriesDateImageView)
        }
        
        clipsToBounds = true
        seriesGenreLabel.textAlignment = .left
        seriesGenreLabel.font = Font.avenir(weight: .regular, size: 10)
        seriesGenreLabel.textColor = .dynamicColor(dynamic: .textColour)
        seriesGenreLabel.numberOfLines = 3
        seriesGenreLabel.lineBreakMode = .byWordWrapping
        seriesGenreLabel.snp.makeConstraints { maker in
            maker.left.equalTo(seriesImageView.snp.right).offset(46)
            maker.right.equalToSuperview()
            maker.top.equalTo(seriesGenreImageView).offset(5)
        }
    }
}
