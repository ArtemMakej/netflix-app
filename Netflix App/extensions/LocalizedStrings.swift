//
//  LocalizedStrings.swift
//  Netflix App
//
//  Created by Artem Mackei on 22.07.2024.
//

import Foundation

enum LocalizedStrings {
    case favoritesLabel
    case generalTitleLabel
    case languageInfoLabel
    case languageNameLabel
    case themesScreenLabel
    case aboutAppLabel
    case developerInfoLabel
    case developerFullNameLabel
    case versionAppLabel
    case websiteInfoLabel
    case durationTitleLabel
    case startShowTitleLabel
    case ratingimdbTitleLabel
    case ratingkinopoiskTitleLabel
    case actorsTitleLabel
    case countryTitleLabel
    case theListsTitleLabel
    case genreTitleLabel
    
    var localizeString: String {
        switch self {
        case .favoritesLabel:
            return NSLocalizedString("Favorites", comment: "")
        case .generalTitleLabel:
            return NSLocalizedString("General", comment: "")
        case .languageInfoLabel:
            return NSLocalizedString("Language", comment: "")
        case .languageNameLabel:
            return NSLocalizedString("Russian🔎", comment: "")
        case .themesScreenLabel:
            return NSLocalizedString("Theme", comment: "")
        case .aboutAppLabel:
            return NSLocalizedString("About app", comment: "")
        case .developerInfoLabel:
            return NSLocalizedString("Developer", comment: "")
        case .developerFullNameLabel:
            return NSLocalizedString("Makey Artyom", comment: "")
        case .versionAppLabel:
            return NSLocalizedString("Version", comment: "")
        case .websiteInfoLabel:
            return NSLocalizedString("Website", comment: "")
        case .durationTitleLabel:
            return NSLocalizedString("Duration: ", comment: "")
        case .startShowTitleLabel:
            return NSLocalizedString("Start show: ", comment: "")
        case .ratingimdbTitleLabel:
            return NSLocalizedString("Rating imdb: ", comment: "")
        case .ratingkinopoiskTitleLabel:
            return NSLocalizedString("Rating kinopoisk: ", comment: "")
        case .actorsTitleLabel:
            return NSLocalizedString("Actors: \n", comment: "")
        case .countryTitleLabel:
            return NSLocalizedString("Country: \n", comment: "")
        case .theListsTitleLabel:
            return NSLocalizedString("The Lists: \n", comment: "")
        case .genreTitleLabel:
            return NSLocalizedString("Genre: \n", comment: "")
        }
    }
}

func configurationLocalizedStrings(localizeString: String) -> LocalizedStrings  {
    switch localizeString {
    case LocalizedStrings.favoritesLabel.localizeString:
        return LocalizedStrings.favoritesLabel
    case LocalizedStrings.generalTitleLabel.localizeString:
        return LocalizedStrings.generalTitleLabel
    case LocalizedStrings.languageInfoLabel.localizeString:
        return LocalizedStrings.languageInfoLabel
    case LocalizedStrings.languageNameLabel.localizeString:
        return LocalizedStrings.languageNameLabel
    case LocalizedStrings.themesScreenLabel.localizeString:
        return LocalizedStrings.themesScreenLabel
    case LocalizedStrings.aboutAppLabel.localizeString:
        return LocalizedStrings.aboutAppLabel
    case LocalizedStrings.developerInfoLabel.localizeString:
        return LocalizedStrings.developerInfoLabel
    case LocalizedStrings.developerFullNameLabel.localizeString:
        return LocalizedStrings.developerFullNameLabel
    case LocalizedStrings.versionAppLabel.localizeString:
        return LocalizedStrings.versionAppLabel
    case LocalizedStrings.websiteInfoLabel.localizeString:
        return LocalizedStrings.websiteInfoLabel
    case LocalizedStrings.durationTitleLabel.localizeString:
        return LocalizedStrings.durationTitleLabel
    case LocalizedStrings.startShowTitleLabel.localizeString:
        return LocalizedStrings.startShowTitleLabel
    case LocalizedStrings.ratingimdbTitleLabel.localizeString:
        return LocalizedStrings.ratingimdbTitleLabel
    case LocalizedStrings.ratingkinopoiskTitleLabel.localizeString:
        return LocalizedStrings.ratingkinopoiskTitleLabel
    case LocalizedStrings.actorsTitleLabel.localizeString:
        return LocalizedStrings.actorsTitleLabel
    case LocalizedStrings.countryTitleLabel.localizeString:
        return LocalizedStrings.countryTitleLabel
    case LocalizedStrings.theListsTitleLabel.localizeString:
        return LocalizedStrings.theListsTitleLabel
    case LocalizedStrings.genreTitleLabel.localizeString:
        return LocalizedStrings.genreTitleLabel
    default:
        return .genreTitleLabel
    }
}
