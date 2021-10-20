//
//  String+SHA256.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

import Foundation
import CommonCrypto

extension String {
    func sha256() -> String {
        guard let data = self.data(using: .utf8) else { return ""}
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        return String(data: Data(hash), encoding: .ascii) ?? ""
    }
}
