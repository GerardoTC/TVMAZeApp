//
//  SecureStoreMock.swift
//  TVMaze AppTests
//
//  Created by Gerardo Tarazona Caceres on 20/10/21.
//

@testable import TVMaze_App

class DataStoreMock: LocalStore {
    var expectedValues: [String: Any?] = [:]
    
    subscript(key: String) -> String {
        get {
            (expectedValues[key] as? String) ?? ""
        }
        set(newValue) {
            expectedValues[key] = newValue
        }
    }
    
    subscript(key: String) -> Int {
        get {
            (expectedValues[key] as? Int) ?? 0
        }
        set(newValue) {
            expectedValues[key] = newValue
        }
    }
    
    subscript(key: String) -> Bool {
        get {
            (expectedValues[key] as? Bool) ?? false
        }
        set(newValue) {
            expectedValues[key] = newValue
        }
    }
    
    func delete(key: String) {
        expectedValues[key] = nil
    }
    
    
}
