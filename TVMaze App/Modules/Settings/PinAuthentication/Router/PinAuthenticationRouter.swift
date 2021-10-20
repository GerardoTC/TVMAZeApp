//
//  PinAuthenticationRouter.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

import UIKit

final class PinAuthenticationRouter: PinAuthenticationRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createPinAuthenticationModule(validationType: PinAuthenticationType, delegate: PinDelegateResult?, currentPin: String? = nil, hideCloseButton: Bool = false) -> PinAuthenticationViewController? {
        
        let ref = PinAuthenticationViewController.create(from: .pinAuthentication)
        let presenter: PinAuthenticationPresenterProtocol & PinAuthenticationInteractorOutputProtocol = PinAuthenticationPresenter()
        presenter.validationType = validationType
        presenter.result = delegate
        presenter.currentPin = currentPin
        presenter.hideCloseButton = hideCloseButton
        let router = PinAuthenticationRouter()
        router.viewController = ref
        
        let interactor = PinAuthenticationInteractor()
        interactor.presenter = presenter
        
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        
        ref?.presenter = presenter
        return ref
    }
    
    func routeToReEnterPin(_ delegate: PinDelegateResult?, _ currentPin: String?) {
        guard let delegate = delegate,
              let reEnterPin = PinAuthenticationRouter.createPinAuthenticationModule(validationType: .reEnterPin, delegate: delegate, currentPin: currentPin) else { return }
        viewController?.navigationController?.pushViewController(reEnterPin, animated: true)
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}

