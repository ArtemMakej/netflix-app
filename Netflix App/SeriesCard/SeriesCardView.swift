//
//  SeriesCardCell.swift
//  Netflix App
//
//  Created by Artem Mackei on 11.12.2023.
//

import UIKit
import SnapKit

final class SeriesCardView: UIView {
    
    private let scrollView = UIScrollView()
    private let customContentView = UIView()
    private let seriesFullImageView = UIImageView()
    private let seriesPlayButton = UIButton()
    private let seriesLikeAndDislikeButton = UIButton()
    private let seriesTitleLabel = UILabel()
    private let seriesDescriptionLabel = UILabel()
    private let seriesDurationLabel = UILabel()
    private let seriesDurationImageView = UIImageView()
    private let seriesPresentedAtDateLabel = UILabel()
    private let seriesPresentedAtDateImageView = UIImageView()
    private let seriesRatingImdbLabel = UILabel()
    private let seriesRatingImdbImageView = UIImageView()
    private let seriesRatingKinopoiskLabel = UILabel()
    private let seriesRatingKinopoiskImageView = UIImageView()
    private let seriesActorsLabel = UILabel()
    private let seriesActorsImageView = UIImageView()
    private let seriesCountryLabel = UILabel()
    private let seriesCountryImageView = UIImageView()
    private let seriesInListsLabel = UILabel()
    private let seriesInListsImageView = UIImageView()
    private let seriesGenreLabel = UILabel()
    private let seriesGenreImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: NetflixFull) {
        let imageUrl = model.full_image_url
        print("imageURL \(imageUrl)")
        loadImageSeriesCard(imageURL: imageUrl)
        seriesTitleLabel.text = model.title
        seriesDescriptionLabel.text = model.description
        seriesDurationLabel.text = "Длительность: \(model.duration)"
        seriesPresentedAtDateLabel.text = model.presented_at_date
        seriesPresentedAtDateLabel.text = "Старт показа: \(model.presented_at_date)"
        seriesRatingImdbLabel.text = model.rating.imbd
        seriesRatingImdbLabel.text = "Рейтинг imdb: \(model.rating.imbd)"
        seriesRatingKinopoiskLabel.text = model.rating.kinopoisk
        seriesRatingKinopoiskLabel.text = "Рейтинг kinopoisk: \(model.rating.kinopoisk)"
        let separetedseriesActors = model.actors.joined(separator: ", ")
        seriesActorsLabel.text = separetedseriesActors
        seriesActorsLabel.text = "Актеры: \(model.actors.joined(separator: ", "))"
        let separetedseriesCountry = model.country.joined(separator: ", ")
        seriesCountryLabel.text = separetedseriesCountry
        seriesCountryLabel.text = "Страна: \(model.country.joined(separator: ", "))"
        let separetedInLists = model.in_lists.joined(separator: ", ")
        seriesInListsLabel.text = separetedInLists
        seriesInListsLabel.text = "В списках: \(model.in_lists.joined(separator: ", "))"
        let separetedGenge = model.genre.joined(separator: ", ")
        seriesGenreLabel.text = separetedGenge
        seriesGenreLabel.text = "Жанр: \(model.genre.joined(separator: ", "))"
    }
    
    private func setupScrollView() {
        self.addSubview(scrollView)
        scrollView.bounces = false
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupContentView() {
        scrollView.addSubview(customContentView)
        customContentView.addSubview(seriesFullImageView)
        customContentView.addSubview(seriesPlayButton)
        customContentView.addSubview(seriesLikeAndDislikeButton)
        customContentView.addSubview(seriesTitleLabel)
        customContentView.addSubview(seriesDescriptionLabel)
        customContentView.addSubview(seriesDurationLabel)
        customContentView.addSubview(seriesDurationImageView)
        customContentView.addSubview(seriesPresentedAtDateLabel)
        customContentView.addSubview(seriesPresentedAtDateImageView)
        customContentView.addSubview(seriesRatingImdbLabel)
        customContentView.addSubview(seriesRatingImdbImageView)
        customContentView.addSubview(seriesRatingKinopoiskLabel)
        customContentView.addSubview(seriesRatingKinopoiskImageView)
        customContentView.addSubview(seriesActorsLabel)
        customContentView.addSubview(seriesActorsImageView)
        customContentView.addSubview(seriesCountryLabel)
        customContentView.addSubview(seriesCountryImageView)
        customContentView.addSubview(seriesInListsLabel)
        customContentView.addSubview(seriesInListsImageView)
        customContentView.addSubview(seriesGenreLabel)
        customContentView.addSubview(seriesGenreImageView)
        
        customContentView.clipsToBounds = true
        customContentView.layer.cornerRadius = 8
        customContentView.backgroundColor = .dynamicColor(dynamic: .appBackground)
        customContentView.snp.makeConstraints { maker in
            maker.width.equalToSuperview()
            maker.height.equalTo(1300)
            maker.edges.equalToSuperview()
        }
        
        seriesFullImageView.clipsToBounds = true
        seriesFullImageView.contentMode = .scaleAspectFill
        seriesFullImageView.snp.makeConstraints { maker in
            maker.left.top.equalToSuperview()
            maker.height.equalTo(393)
            maker.width.equalToSuperview()
        }
        
        seriesLikeAndDislikeButton.clipsToBounds = true
        seriesLikeAndDislikeButton.tintColor = UIColor.imageColor.color
        let likeandDislikeImage = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
        seriesLikeAndDislikeButton.setImage(likeandDislikeImage, for: .normal)
        seriesLikeAndDislikeButton.snp.makeConstraints { maker in
            maker.left.equalTo(self.safeAreaLayoutGuide.snp.left).inset(144)
            maker.top.equalTo(seriesFullImageView.safeAreaLayoutGuide.snp.bottom).inset(-15)
        }
        
        seriesPlayButton.clipsToBounds = true
        seriesPlayButton.tintColor = UIColor.imageColor.color
        let playImage = UIImage(named: "play")?.withRenderingMode(.alwaysTemplate)
        seriesPlayButton.setImage(playImage, for: .normal)
        seriesPlayButton.snp.makeConstraints { maker in
            maker.left.equalTo(seriesLikeAndDislikeButton.snp.right).inset(-30)
            maker.top.equalTo(seriesLikeAndDislikeButton)
            maker.size.equalTo(seriesLikeAndDislikeButton)
        }
        
        seriesDescriptionLabel.clipsToBounds = true
        seriesDescriptionLabel.textColor = .dynamicColor(dynamic: .textColourCustom)
        seriesDescriptionLabel.numberOfLines = 0
        seriesDescriptionLabel.snp.makeConstraints { maker in
            maker.top.equalTo(seriesFullImageView.snp.bottom).inset(-70)
            maker.left.equalTo(customContentView.safeAreaLayoutGuide).inset(16)
            maker.right.equalTo(customContentView.safeAreaLayoutGuide).inset(-16)
            maker.width.equalToSuperview().inset(16)
        }
        
        seriesDurationImageView.clipsToBounds = true
        let durationImage = UIImage(named: "duration")?.withRenderingMode(.alwaysTemplate)
        seriesDurationImageView.image = durationImage
        seriesDurationImageView.tintColor = UIColor.imageColor.color
        seriesDurationImageView.snp.makeConstraints { maker in
            maker.top.equalTo(seriesDescriptionLabel.snp.bottom).inset(-22)
            maker.left.equalTo(seriesDescriptionLabel)
            maker.height.equalTo(22)
            maker.width.equalTo(22)
        }
        
        seriesDurationLabel.clipsToBounds = true
        seriesDurationLabel.textColor = .dynamicColor(dynamic: .textColourCustom)
        seriesDurationLabel.snp.makeConstraints { maker in
            maker.top.equalTo(seriesDurationImageView.snp.top)
            maker.left.equalTo(seriesDurationImageView.snp.right).inset(-8)
            maker.right.equalToSuperview().inset(8)
        }
        
        seriesPresentedAtDateImageView.clipsToBounds = true
        seriesPresentedAtDateImageView.tintColor = UIColor.imageColor.color
        let presentedAtDateImage = UIImage(named: "presentedAtDate")?.withRenderingMode(.alwaysTemplate)
        seriesPresentedAtDateImageView.image = presentedAtDateImage
        seriesPresentedAtDateImageView.snp.makeConstraints { maker in
            maker.top.equalTo(seriesDurationLabel.snp.bottom).inset(-8)
            maker.left.equalTo(seriesDurationImageView)
            maker.height.equalTo(22)
            maker.width.equalTo(22)
        }
        
        seriesPresentedAtDateLabel.clipsToBounds = true
        seriesPresentedAtDateLabel.textColor = .dynamicColor(dynamic: .textColourCustom)
        seriesPresentedAtDateLabel.snp.makeConstraints { maker in
            maker.top.equalTo(seriesPresentedAtDateImageView.snp.top)
            maker.left.equalTo(seriesDurationLabel)
        }
        
        seriesRatingImdbImageView.clipsToBounds = true
        seriesRatingImdbImageView.tintColor = UIColor.imageColor.color
        let ratingImdbImage = UIImage(named: "rating")?.withRenderingMode(.alwaysTemplate)
        seriesRatingImdbImageView.image = ratingImdbImage
        seriesRatingImdbImageView.snp.makeConstraints { maker in
            maker.top.equalTo(seriesPresentedAtDateLabel.snp.bottom).inset(-8)
            maker.left.equalTo(seriesPresentedAtDateImageView)
            maker.width.equalTo(22)
            maker.height.equalTo(22)
        }
        
        seriesRatingImdbLabel.clipsToBounds = true
        seriesRatingImdbLabel.textColor = .dynamicColor(dynamic: .textColourCustom)
        seriesRatingImdbLabel.snp.makeConstraints { maker in
            maker.top.equalTo(seriesRatingImdbImageView.snp.top)
            maker.left.equalTo(seriesPresentedAtDateLabel)
        }
        
        seriesRatingKinopoiskImageView.clipsToBounds = true
        seriesRatingKinopoiskImageView.tintColor = UIColor.imageColor.color
        let ratingKinopoiskImage = UIImage(named: "rating")?.withRenderingMode(.alwaysTemplate)
        seriesRatingKinopoiskImageView.image = ratingKinopoiskImage
        seriesRatingKinopoiskImageView.snp.makeConstraints { maker in
            maker.top.equalTo(seriesRatingImdbLabel.snp.bottom).inset(-8)
            maker.left.equalTo(seriesPresentedAtDateImageView)
            maker.height.equalTo(22)
            maker.width.equalTo(22)
        }
        
        seriesRatingKinopoiskLabel.clipsToBounds = true
        seriesRatingKinopoiskLabel.textColor = .dynamicColor(dynamic: .textColourCustom)
        seriesRatingKinopoiskLabel.snp.makeConstraints { maker in
            maker.top.equalTo(seriesRatingKinopoiskImageView.snp.top)
            maker.left.equalTo(seriesRatingImdbLabel)
        }
        
        seriesActorsImageView.clipsToBounds = true
        seriesActorsImageView.tintColor = UIColor.imageColor.color
        let actorsImage = UIImage(named: "actors")?.withRenderingMode(.alwaysTemplate)
        seriesActorsImageView.image = actorsImage
        seriesActorsImageView.snp.makeConstraints { maker in
            maker.top.equalTo(seriesRatingKinopoiskLabel.snp.bottom).inset(-8)
            maker.left.equalTo(seriesRatingKinopoiskImageView)
            maker.width.equalTo(22)
            maker.height.equalTo(22)
        }
        
        seriesActorsLabel.clipsToBounds = true
        seriesActorsLabel.numberOfLines = 0
        seriesActorsLabel.textColor = .dynamicColor(dynamic: .textColourCustom)
        seriesActorsLabel.snp.makeConstraints { maker in
            maker.top.equalTo(seriesActorsImageView.snp.top)
            maker.right.equalTo(customContentView.safeAreaLayoutGuide).offset(-16)
            maker.left.equalTo(seriesRatingKinopoiskLabel)
        }
        
        seriesCountryImageView.clipsToBounds = true
        seriesCountryImageView.tintColor = UIColor.imageColor.color
        let countryImage = UIImage(named: "country")?.withRenderingMode(.alwaysTemplate)
        seriesCountryImageView.image = countryImage
        seriesCountryImageView.snp.makeConstraints { maker in
            maker.top.equalTo(seriesActorsLabel.snp.bottom).inset(-8)
            maker.left.equalTo(seriesActorsImageView)
            maker.height.equalTo(22)
            maker.width.equalTo(22)
        }
        
        seriesCountryLabel.clipsToBounds = true
        seriesCountryLabel.textColor = .dynamicColor(dynamic: .textColourCustom)
        seriesCountryLabel.snp.makeConstraints { maker in
            maker.top.equalTo(seriesCountryImageView.snp.top)
            maker.left.equalTo(seriesActorsLabel)
        }
        
        seriesInListsImageView.clipsToBounds = true
        seriesInListsImageView.tintColor = UIColor.imageColor.color
        let listsImage = UIImage(named: "lists")?.withRenderingMode(.alwaysTemplate)
        seriesInListsImageView.image = listsImage
        seriesInListsImageView.snp.makeConstraints { maker in
            maker.top.equalTo(seriesCountryLabel.snp.bottom).inset(-8)
            maker.left.equalTo(seriesCountryImageView)
            maker.width.equalTo(22)
            maker.height.equalTo(22)
        }
        
        seriesInListsLabel.clipsToBounds = true
        seriesInListsLabel.textColor = .dynamicColor(dynamic: .textColourCustom)
        seriesInListsLabel.numberOfLines = 0
        seriesInListsLabel.snp.makeConstraints { maker in
            maker.top.equalTo(seriesInListsImageView.snp.top)
            maker.right.equalTo(customContentView.safeAreaLayoutGuide).offset(-16)
            maker.left.equalTo(seriesCountryLabel)
        }
        
        seriesGenreImageView.clipsToBounds = true
        seriesGenreImageView.tintColor = UIColor.imageColor.color
        let genreImage = UIImage(named: "genre")?.withRenderingMode(.alwaysTemplate)
        seriesGenreImageView.image = genreImage
        seriesGenreImageView.snp.makeConstraints { maker in
            maker.top.equalTo(seriesInListsLabel.snp.bottom).inset(-8)
            maker.left.equalTo(seriesInListsImageView)
            maker.height.equalTo(22)
            maker.width.equalTo(22)
        }
        
        seriesGenreLabel.clipsToBounds = true
        seriesGenreLabel.numberOfLines = 0
        seriesGenreLabel.textColor = .dynamicColor(dynamic: .textColourCustom)
        seriesGenreLabel.snp.makeConstraints { maker in
            maker.top.equalTo(seriesGenreImageView.snp.top)
            maker.left.equalTo(seriesInListsLabel)
            maker.right.equalTo(seriesInListsLabel)
        }
    }
}

extension SeriesCardView {
    func loadImageSeriesCard(imageURL: String?) {
        guard let imageURL = imageURL else { return }
        guard let url = URL(string: imageURL) else { return }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Ошибка загрузки изображения: \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async { [ weak self ] in
                self?.seriesFullImageView.image = image
            }
        }.resume()
    }
}
