//
//  FavoriteShowsListRouter.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 20/10/21.
//

import UIKit

final class FavoriteShowsListRouter: FavoriteShowsListRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createFavoriteShowsListModule() -> FavoriteShowsListViewController? {
        let ref = FavoriteShowsListViewController.create(from: .favoriteShowsList)
        
        let presenter: FavoriteShowsListPresenterProtocol & FavoriteShowsListInteractorOutputProtocol = FavoriteShowsListPresenter()
        
        let router = FavoriteShowsListRouter()
        router.viewController = ref
        
        let interactor = FavoriteShowsListInteractor()
        interactor.presenter = presenter
        
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        
        ref?.presenter = presenter
        return ref
    }
    
    func routeToDetail(id: Int) {
        guard let showDetailVC = ShowDetailRouter.createShowDetailModule(id: id) else { return }
        viewController?.navigationController?.pushViewController(showDetailVC, animated: true)
    }
}

