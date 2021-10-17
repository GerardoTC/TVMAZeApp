//
//  Data+Extensions.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 17/10/21.
//

import Foundation

extension Data {
    var htmlToAttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var htmlToString: String { htmlToAttributedString?.string ?? "" }
}
