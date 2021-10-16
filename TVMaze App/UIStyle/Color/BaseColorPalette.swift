//
//  BaseColorPalette.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import UIKit

enum BaseColorPalette {
    var color: UIColor {
        switch self {
        case .textColor:
            return UIColor(named: "textColor") ?? UIColor.colorFrom(hex: "#262223")
        case .textColorSecondary:
            return UIColor(named: "textColorSecondary") ?? UIColor.colorFrom(hex: "#586173")
        case .bgColor:
            return UIColor(named: "bgColor") ?? UIColor.colorFrom(hex: "#FFFFFF")
        case .bgColorSecondary:
            return UIColor(named: "bgColorSecondary") ?? UIColor.colorFrom(hex: "#F2F2F2")
        case .accentColor:
            return UIColor(named: "accentColor") ?? UIColor.colorFrom(hex: "#35BDF2")
        case .tintColor:
            return UIColor(named: "tintColor") ?? UIColor.colorFrom(hex: "#35BDF2")
        case .tintColorSecondary:
            return UIColor(named: "tintColorSecondary") ?? UIColor.colorFrom(hex: "#8DD5F2")
        }
    }
    /// Hex Value = #262223
    case textColor
    /// Hex Value = #586173
    case textColorSecondary
    /// Hex Value = #FFFFFF
    case bgColor
    /// Hex Value = #F2F2F2
    case bgColorSecondary
    /// Hex Value = #35BDF2
    case accentColor
    /// Hex Value = #35BDF2
    case tintColor
    /// Hex Value = #8DD5F2
    case tintColorSecondary
}
