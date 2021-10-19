//
//  PinAuthenticationRouter.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

import UIKit

final class PinAuthenticationRouter: PinAuthenticationRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createPinAuthenticationModule() -> PinAuthenticationViewController? {
        let ref = PinAuthenticationViewController.create(from: .pinAuthentication)
        
        let presenter: PinAuthenticationPresenterProtocol & PinAuthenticationInteractorOutputProtocol = PinAuthenticationPresenter()
        
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
}

