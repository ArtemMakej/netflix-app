//
//  NetflixCell.swift
//  Netflix App
//
//  Created by Artem Mackei on 11.10.2023.
//

import UIKit

final class NetflixCell: UICollectionViewCell {
    
    static let id = "NetflixCell"
    private let baseView = UIView()
    private let seriesNameImageView = UIImageView()
    private let seriesDateImageView = UIImageView()
    private let seriesGenreImageView = UIImageView()
    private let seriesImageView = UIImageView()
    private let seriesNameLabel = UILabel()
    private let seriesDateLabel = UILabel()
    private let seriesGenreLabel = UILabel()
    
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
        
        //        /// 1 способ разбить строку more
        //        var didFindStopAnchor = false
        //        var date = ""
        //        var info = ""
        //
        //        for char in more {
        //            if char == "," {
        //                didFindStopAnchor = true
        //                continue
        //            }
        //
        //            if !didFindStopAnchor {
        //                date += String(char)
        //            } else {
        //                info += String(char)
        //            }
        //        }
        
        /// 2 способ разбить строку more
        let separetedMore = more.components(separatedBy: [","])
        let newDate = separetedMore[0]
        let newInfo = separetedMore[1...]
        /// заполняем
        seriesDateLabel.text = newDate
        seriesGenreLabel.text = Array(newInfo).joined(separator: ",")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ///метод позволят отрисовать вью сейчас
        baseView.layoutIfNeeded()
        setupGradientBackground(dynamic: .appBackground)
    }
    
    private func setupGradientBackground(dynamic: UIColor.Dynamic) {
        let gradientLayer = CAGradientLayer()
        if dynamic.light.isEqual(UIColor.Dynamic.basic.light) && dynamic.dark.isEqual(UIColor.Dynamic.basic.dark) {
        gradientLayer.colors = [
            UIColor(
                red: 217/255,
                green: 233/255,
                blue: 250/255,
                alpha: 1).cgColor,
            UIColor(red: 206/255,
                    green: 236/255,
                    blue: 218/255,
                    alpha: 1).cgColor,
            UIColor(red: 201/255,
                    green: 245/255,
                    blue: 183/255,
                    alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 0.8, 1.0]
        gradientLayer.frame = baseView.bounds
        baseView.layer.insertSublayer(gradientLayer, at: 0)
        } else {
                // В противном случае, используем темный или светлый цвет в зависимости от темы
            baseView.backgroundColor = UIColor(red: 35/255, green: 38/255, blue: 46/255, alpha: 1)
            }
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
            maker.edges.equalToSuperview().inset(16)
        }
        
        seriesNameImageView.image = UIImage(named: "nameSeries")
        seriesNameImageView.snp.makeConstraints { maker in
            maker.left.equalTo(seriesImageView.snp.right).offset(16)
            maker.top.equalTo(seriesImageView).offset(42)
            maker.height.equalTo(22)
            maker.width.equalTo(22)
        }
        
        seriesDateImageView.clipsToBounds = true
        seriesDateImageView.image = UIImage(named: "SeriesDate")
        seriesDateImageView.snp.makeConstraints { maker in
            maker.left.equalTo(seriesImageView.snp.right).offset(16)
            maker.top.equalTo(seriesNameImageView.snp.bottom).offset(8)
            maker.height.equalTo(22)
            maker.width.equalTo(22)
        }
        
        seriesGenreImageView.clipsToBounds = true
        seriesGenreImageView.image = UIImage(named: "SeriesGenre")
        seriesGenreImageView.snp.makeConstraints { maker in
            maker.left.equalTo(seriesImageView.snp.right).offset(16)
            maker.top.equalTo(seriesDateImageView.snp.bottom).offset(8)
            maker.height.equalTo(22)
            maker.width.equalTo(22)
        }
        
        seriesImageView.contentMode = .scaleAspectFill
        seriesImageView.image = UIImage(named: "pictureSeries")
        seriesImageView.layer.shadowColor = UIColor.black.cgColor
        seriesImageView.layer.shadowOpacity = 0.5
        seriesImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        seriesImageView.layer.shadowRadius = 5.0
        seriesImageView.layer.masksToBounds = false
        seriesImageView.layer.cornerRadius = 8
        seriesImageView.clipsToBounds =  true
        seriesImageView.snp.makeConstraints { maker in
            maker.left.top.equalTo(baseView)
            maker.height.equalToSuperview()
            maker.width.equalTo(160)
        }
        
        clipsToBounds = true
        seriesNameLabel.textAlignment = .left
        seriesNameLabel.font = .boldSystemFont(ofSize: 15)
        seriesNameLabel.textColor = .black
        seriesNameLabel.font = UIFontMetrics.default.scaledFont(for: Font.avenir(
            weight: .bold,
            size: 12)
        )
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
        seriesDateLabel.font = UIFontMetrics.default.scaledFont(for: Font.avenir(
            weight: .medium,
            size: 12)
        )
        seriesDateLabel.textColor = .black
        seriesDateLabel.snp.makeConstraints { maker in
            maker.left.equalTo(seriesImageView.snp.right).offset(46)
            maker.right.equalToSuperview()
            maker.centerY.equalTo(seriesDateImageView)
        }
        
        clipsToBounds = true
        seriesGenreLabel.textAlignment = .left
        seriesGenreLabel.font = UIFontMetrics.default.scaledFont(for: Font.avenir(
            weight: .regular,
            size: 12)
        )
        seriesGenreLabel.textColor = .black
        seriesGenreLabel.numberOfLines = 3
        seriesGenreLabel.lineBreakMode = .byWordWrapping
        seriesGenreLabel.snp.makeConstraints { maker in
            maker.left.equalTo(seriesImageView.snp.right).offset(46)
            maker.right.equalToSuperview()
            maker.top.equalTo(seriesGenreImageView).offset(5)
        }
    }
}
