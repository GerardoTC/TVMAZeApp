//
//  AppSettingsRouter.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

import UIKit

final class AppSettingsRouter: AppSettingsRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createAppSettingsModule() -> AppSettingsViewController? {
        let ref = AppSettingsViewController.create(from: .appSettings)
        
        let presenter: AppSettingsPresenterProtocol & AppSettingsInteractorOutputProtocol = AppSettingsPresenter()
        
        let router = AppSettingsRouter()
        router.viewController = ref
        
        let interactor = AppSettingsInteractor()
        interactor.presenter = presenter
        
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        
        ref?.presenter = presenter
        return ref
    }
    
    func routeToPin(validationType: PinAuthenticationType, delegate: PinDelegateResult) {
        guard let vc = PinAuthenticationRouter.createPinAuthenticationModule(validationType: validationType, delegate: delegate) else { return }
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        viewController?.present(navController, animated: true, completion: nil)
    }
}

