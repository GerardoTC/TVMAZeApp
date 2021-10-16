//
//  UIColor+Extensions.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import UIKit

extension UIColor {
    static func colorFrom(hex: String) -> UIColor {
        var baseString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (baseString.hasPrefix("#")) {
            baseString.remove(at: baseString.startIndex)
        }
        
        guard baseString.count == 6 else {
            return UIColor.black
        }
        
        var rgbUInt: UInt64 = 0
        Scanner(string: baseString).scanHexInt64(&rgbUInt)
        
        return UIColor(red: CGFloat((rgbUInt & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgbUInt & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(rgbUInt & 0x0000FF) / 255.0,
                       alpha: CGFloat(1.0))
    }
}
