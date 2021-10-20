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
        }
    }
    case showsTabIcon
    case appSettingsIcon
}
