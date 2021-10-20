//
//  DefaultStore.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

import Foundation

class DefaultStore: LocalStore {
    subscript(key: String) -> String {
        get {
            UserDefaults.standard.string(forKey: key) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
    
    subscript(key: String) -> Int {
        get {
            UserDefaults.standard.integer(forKey: key)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
    
    subscript(key: String) -> Bool {
        get {
            UserDefaults.standard.bool(forKey: key)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
    
    func delete(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
