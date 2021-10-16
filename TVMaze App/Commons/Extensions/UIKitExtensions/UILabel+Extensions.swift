//
//  UILabel+Extensions.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import UIKit

extension UILabel {
    func setFont(_ style: FontStyle) {
        self.font = style.font
        self.adjustsFontForContentSizeCategory = true
    }
}
