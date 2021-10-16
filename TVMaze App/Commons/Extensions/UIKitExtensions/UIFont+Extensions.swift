//
//  UIFont+Extensions.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import UIKit

extension UIFont {
    static func font(name: String, size: CGFloat, maximumSize: CGFloat) -> UIFont {
        let baseFont = UIFont(name: name, size: size) ?? .systemFont(ofSize: size)
        return UIFontMetrics.default.scaledFont(for: baseFont, maximumPointSize: maximumSize)
    }
}
