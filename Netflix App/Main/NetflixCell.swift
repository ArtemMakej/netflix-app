//
//  NetflixCell.swift
//  Netflix App
//
//  Created by Artem Mackei on 11.10.2023.
//

import UIKit

final class NetflixCell: UICollectionViewCell {
    
    static let id = "NetflixCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        /// настройка ячейки
    }
    
    func configure(model: TvShowModel) {
    }
    
}
