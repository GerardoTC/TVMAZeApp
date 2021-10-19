//
//  SecureStore.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

import Foundation

class SecureStore: LocalStore {
    /// String SecureStore
    subscript(key: String) -> String {
        get {
            let stringData = get(key: key)
            return String.decode(from: stringData) ?? ""
        }
        set {
            save(key: key, value: newValue.data(using: .utf8))
        }
    }
    
    /// Bool Secure store
    subscript(key: String) -> Bool {
        get {
            let boolData = get(key: key)
            return Bool.decode(from: boolData) ?? false
        }
        set {
            save(key: key, value: newValue.encodeToData())
        }
    }
    
    ///Integer Secure store
    subscript(key: String) -> Int {
        get {
            let integerData = get(key: key)
            return Int.decode(from: integerData) ?? 0
        }
        set {
            save(key: key, value: newValue.encodeToData())
        }
    }
    
    private func save(key: String, value: Data?) {
        if get(key: key) != nil{
            delete(key: key)
        }
        guard let value = value else { return }
        SecItemAdd(baseSaveQuery(key: key, value: value), nil)
    }
    
    private func get(key: String) -> Data? {
        var result: AnyObject?
        SecItemCopyMatching(baseQuery(key: key), &result)
        let dic = result as? NSDictionary
        guard let passwordData = dic?[kSecValueData] as? Data else {
            print("Unable to retrieve Data")
            return nil
        }
        return passwordData
    }
    
    func delete(key: String) {
        SecItemDelete(baseQuery(key: key))
    }
}

private extension LocalStore {
    func baseQuery(key: String) -> CFDictionary {
        [kSecClass: kSecClassGenericPassword,
         kSecReturnAttributes: true,
         kSecReturnData: true,
         kSecAttrService: key,
        ] as CFDictionary
    }
    
    func baseSaveQuery(key: String, value: Data) -> CFDictionary {
        [ kSecClass: kSecClassGenericPassword,
          kSecValueData: value,
          kSecAttrService: key
        ] as CFDictionary
    }
}

private extension Decodable {
    static func decode(from data: Data?) -> Self? {
        guard let data = data else { return nil }
        return try? JSONDecoder().decode(Self.self, from: data)
    }
}

private extension Encodable {
    func encodeToData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
