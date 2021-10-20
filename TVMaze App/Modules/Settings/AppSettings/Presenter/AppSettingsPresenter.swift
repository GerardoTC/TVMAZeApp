//
//  AppSettingsPresenter.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

final class AppSettingsPresenter: AppSettingsPresenterProtocol {
    
    weak var view: AppSettingsViewProtocol?
    var router: AppSettingsRouterProtocol?
    var interactor: AppSettingsInteractorProtocol?
    var biometricsManager: LocalBiometricAuthenticationManager? = AuthenticationManager()
    
    func viewDidLoad() {
        updateStatuses()
        biometricsManager?.delegate = self
    }
    
    func pinStatusChanged(_ value: Bool) {
        router?.routeToPin(validationType: value ? .registerPin : .disablePin, delegate: self)
    }
    
    func biometricsStatusChanged(_ value: Bool) {
        biometricsManager?.startBiometricAuthentication()
    }
    
    func darkModeStatusChanged(_ value: Bool) {
        interactor?.updateDarkModeStatus(isOn: value)
    }
    
    private func updateStatuses() {
        view?.updateSwitchesInfo(interactor?.isPinOn() ?? false,
                                 interactor?.isBiometricsOn() ?? false,
                                 interactor?.isDarkModeOn() ?? false)
    }
}

extension AppSettingsPresenter: AppSettingsInteractorOutputProtocol {}

extension AppSettingsPresenter: PinDelegateResult {
    func handlePinEndValidation() {
        updateStatuses()
    }
}

extension AppSettingsPresenter: BiometricAuthenticationManagerDelegate {
    func authenticationSuccess() {
        if interactor?.isBiometricsOn() ?? false {
            interactor?.disableBiometrics()
        } else {
            interactor?.enableBiometrics()
        }
    }
    
    func authenticationFailed(error: BiometricAuthenticationError) {
        router?.presentAlertError(error: error)
        updateStatuses()
    }
}
