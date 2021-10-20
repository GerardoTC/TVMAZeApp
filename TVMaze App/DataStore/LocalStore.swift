//
//  LocalStore.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

import Foundation

protocol LocalStore {
    subscript(key: String) -> String {get set}
    subscript(key: String) -> Int {get set}
    subscript(key: String) -> Bool {get set}
    func delete(key: String)
}
