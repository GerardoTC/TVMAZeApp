//
//  String+Localizable.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, comment: "")
    }
}
