//
//  ShowsSearchRouter.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import UIKit

final class ShowsSearchRouter: ShowsSearchRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createShowsSearchModule() -> ShowsSearchViewController? {
        let ref = ShowsSearchViewController.create(from: .showsSearch)
        
        let presenter: ShowsSearchPresenterProtocol & ShowsSearchInteractorOutputProtocol = ShowsSearchPresenter()
        
        let router = ShowsSearchRouter()
        router.viewController = ref
        
        let interactor = ShowsSearchInteractor()
        interactor.presenter = presenter
        
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        
        ref?.presenter = presenter
        return ref
    }
}

