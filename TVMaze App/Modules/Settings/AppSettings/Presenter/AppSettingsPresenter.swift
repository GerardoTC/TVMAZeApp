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
    
    func viewDidLoad() {
        updateStatuses()
    }
    
    func pinStatusChanged(_ value: Bool) {
        
    }
    
    func biometricsStatusChanged(_ value: Bool) {
        
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
