//
//  AppSettingsProtocols.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//
import UIKit

protocol AppSettingsInteractorProtocol: AnyObject {
    var presenter: AppSettingsInteractorOutputProtocol? { get set }
    func updateDarkModeStatus(isOn: Bool)
    func isDarkModeOn() -> Bool
    func setupPinValue(pin: String)
    func isPinOn() -> Bool
    func isBiometricsOn() -> Bool
    func disableBiometrics()
    func enableBiometrics()
}

protocol AppSettingsPresenterProtocol: AnyObject {
    var view: AppSettingsViewProtocol? { get set }
    var router: AppSettingsRouterProtocol? { get set }
    var interactor: AppSettingsInteractorProtocol? { get set }
    
    func viewDidLoad()
    func pinStatusChanged(_ value: Bool)
    func biometricsStatusChanged(_ value: Bool)
    func darkModeStatusChanged(_ value: Bool)
}

protocol AppSettingsInteractorOutputProtocol: AnyObject {
}

protocol AppSettingsRouterProtocol: BaseRouterWithError {
    var viewController: UIViewController? { get set }
    
    static func createAppSettingsModule() -> AppSettingsViewController?
    func routeToPin(validationType: PinAuthenticationType, delegate: PinDelegateResult)
}

protocol AppSettingsViewProtocol: AnyObject {
    var presenter: AppSettingsPresenterProtocol? { get set }
    func updateSwitchesInfo(_ pinStatus: Bool, _ biometricsStatus: Bool, _ darkModeStatus: Bool)
}
