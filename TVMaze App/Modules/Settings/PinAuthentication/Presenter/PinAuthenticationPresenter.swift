//
//  PinAuthenticationPresenter.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

final class PinAuthenticationPresenter: PinAuthenticationPresenterProtocol {
    weak var view: PinAuthenticationViewProtocol?
    var router: PinAuthenticationRouterProtocol?
    var interactor: PinAuthenticationInteractorProtocol?
    var validationType: PinAuthenticationType?
    weak var result: PinDelegateResult?
    var currentPin: String?
    var hideCloseButton: Bool?
    
    func viewDidLoad() {
        view?.updateTitle(validationType?.title ?? "")
    }
    
    func endEditing(pin: String) {
        guard let validationType = validationType else { return }
        switch validationType {
        case .disablePin:
            handleDisablePin(pin: pin)
        case .registerPin:
            router?.routeToReEnterPin(result, pin)
        case .reEnterPin:
            handleReenterPin(pin: pin)
        case .validate:
            handleValidation(pin: pin)
        }
    }
    
    func handleDisablePin(pin: String) {
        if interactor?.validatePin(pin: pin) ?? false{
            interactor?.deletePin()
            result?.handlePinEndValidation()
            router?.dismiss()
        } else {
            router?.presentAlertError(error: PinAuthenticationError.invalidPin)
        }
    }
    
    func handleReenterPin(pin: String) {
        if currentPin == pin {
            interactor?.savePin(pin: pin)
            result?.handlePinEndValidation()
            router?.dismiss()
        } else {
            router?.presentAlertError(error: PinAuthenticationError.invalidReenterPin)
        }
    }
    
    func handleValidation(pin: String) {
        if interactor?.validatePin(pin: pin) ?? false {
            result?.handlePinEndValidation()
            router?.dismiss()
        } else {
            router?.presentAlertError(error: PinAuthenticationError.invalidPin)
        }
    }
    
    func closePressed() {
        result?.handlePinEndValidation()
        router?.dismiss()
    }
}

extension PinAuthenticationPresenter: PinAuthenticationInteractorOutputProtocol {}
