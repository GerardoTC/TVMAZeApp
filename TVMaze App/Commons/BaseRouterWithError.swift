//
//  BaseRouterWithError.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

import UIKit

protocol BaseRouterWithError: AnyObject {
    var viewController: UIViewController? { get set }
    
    func presentAlertError(error: Error)
}

extension BaseRouterWithError {
    func presentAlertError(error: Error) {
        var errorMessage = ""
        switch error {
        
        case NetworkError.connectionError:
            errorMessage = "error.internet_connection".localized
        case NetworkError.serverError:
            errorMessage = "error.server_error".localized
        case PinAuthenticationError.invalidPin:
            errorMessage = "Your pin is invalid, please try again"
        case PinAuthenticationError.invalidReenterPin:
            errorMessage = "PIn does not match with the previous one, please try again"
        case BiometricAuthenticationError.canceled:
            return
        case BiometricAuthenticationError.biometricLockout:
            errorMessage = "Your biometrics authentication is locked"
        case BiometricAuthenticationError.biometricNotConfigured:
            errorMessage = "Your biometrics are not configured, please go to settings and enabled it"
        case BiometricAuthenticationError.failed:
            errorMessage = "Your biometrics authentication was not success, please try again"
        default:
            errorMessage = "error.unexpected_error".localized
        }
        showAlertError(message:  errorMessage)
    }
    
    private func showAlertError(message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "error.title".localized, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "error.ok".localized, style: .default, handler: nil)
            alertController.addAction(okAction)
            alertController.view.tintColor = BaseColorPalette.tintColor.color
            self.viewController?.present(alertController, animated: true, completion: nil)
        }
    }
}
