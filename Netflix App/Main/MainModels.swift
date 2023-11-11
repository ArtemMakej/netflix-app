//
//  MainModel.swift
//  Netflix App
//
//  Created by Artem Mackei on 11.10.2023.
//

import UIKit

struct TvShowModel {
    let name: String
}

enum MainScreenCell {
    case tvShow(model: TvShowModel)
}

enum MainScreenSection {
    case shows(cells: [MainScreenCell])
}
