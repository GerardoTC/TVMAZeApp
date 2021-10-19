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
