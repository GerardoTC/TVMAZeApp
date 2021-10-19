//
//  AppSettingsInteractor.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

final class AppSettingsInteractor: AppSettingsInteractorProtocol {
    weak var presenter: AppSettingsInteractorOutputProtocol?
    var secureStore: LocalStore
    var defaultStore: LocalStore
    
    init(secureStore: LocalStore = SecureStore(), defaultStore: LocalStore = DefaultStore()) {
        self.secureStore = secureStore
        self.defaultStore = defaultStore
    }
    
    func updateDarkModeStatus(isOn: Bool) {
        defaultStore[DefaultStoreKeys.darkModeOn.rawValue] = isOn
    }
    
    func isDarkModeOn() -> Bool {
        defaultStore[DefaultStoreKeys.darkModeOn.rawValue]
    }
    
    func setupPinValue(pin: String) {
        secureStore[SecureStoreKeys.pinValue.rawValue] = pin.sha256()
    }
    
    func isPinOn() -> Bool {
        secureStore[SecureStoreKeys.pinValue.rawValue] != ""
    }
    
    func isBiometricsOn() -> Bool {
        secureStore[SecureStoreKeys.biometricsOn.rawValue]
    }
}
