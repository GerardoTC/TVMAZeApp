//
//  IconProvider.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

import UIKit

enum IconProvider {
    var image: UIImage {
        switch self {
        case .showsTabIcon:
            return #imageLiteral(resourceName: "shows")
        case .appSettingsIcon:
            return #imageLiteral(resourceName: "settings")
        case .favoriteImage(let fill):
            return fill ? UIImage(systemName: "suit.heart.fill") ?? UIImage() : UIImage(systemName: "suit.heart") ?? UIImage()
        }
    }
    case showsTabIcon
    case appSettingsIcon
    case favoriteImage(fill: Bool)
}
