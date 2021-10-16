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
            return UIColor(named: "TextColor") ?? UIColor.colorFrom(hex: "#262223")
        case .textColorSecondary:
            return UIColor(named: "TextColorSecondary") ?? UIColor.colorFrom(hex: "#586173")
        case .bgColor:
            return UIColor(named: "BgColor") ?? UIColor.colorFrom(hex: "#FFFFFF")
        case .bgColorSecondary:
            return UIColor(named: "BgColorSecondary") ?? UIColor.colorFrom(hex: "#F2F2F2")
        case .accentColor:
            return UIColor(named: "AccentColor") ?? UIColor.colorFrom(hex: "#35BDF2")
        case .tintColor:
            return UIColor(named: "TintColor") ?? UIColor.colorFrom(hex: "#35BDF2")
        case .tintColorSecondary:
            return UIColor(named: "TintColorSecondary") ?? UIColor.colorFrom(hex: "#8DD5F2")
        case .clearColor:
            return UIColor.clear
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
    
    case clearColor
}
