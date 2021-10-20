//
//  PinAuthenticationInteractor.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

final class PinAuthenticationInteractor: PinAuthenticationInteractorProtocol {
    weak var presenter: PinAuthenticationInteractorOutputProtocol?
    var secureStore: LocalStore
    
    init(secureStore: LocalStore = SecureStore()) {
        self.secureStore = secureStore
    }
    
    func savePin(pin: String) {
        secureStore[SecureStoreKeys.pinValue.rawValue] = pin.sha256()
    }
    
    func deletePin() {
        secureStore.delete(key: SecureStoreKeys.pinValue.rawValue)
        secureStore.delete(key: SecureStoreKeys.biometricsOn.rawValue)
    }
    
    func validatePin(pin: String) -> Bool {
        secureStore[SecureStoreKeys.pinValue.rawValue] == pin.sha256()
    }
}
