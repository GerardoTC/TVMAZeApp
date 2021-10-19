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
}

