//
//  Codable+Extensions.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import Foundation

extension Decodable {
    static func decode(from data: Data) throws -> Self {
        return try JSONDecoder().decode(Self.self, from: data)
    }
}

extension Encodable {
    func encodeToData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
