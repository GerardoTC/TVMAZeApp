//
//  FavoriteShowsListPresenter.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 20/10/21.
//

final class FavoriteShowsListPresenter: FavoriteShowsListPresenterProtocol {
    weak var view: FavoriteShowsListViewProtocol?
    var router: FavoriteShowsListRouterProtocol?
    var interactor: FavoriteShowsListInteractorProtocol?
    var favoriteShowsList: [ShowInfoModel] = []
    
    func viewDidLoad() {
        favoriteShowsList = interactor?.getAllFavoriteShows() ?? []
        view?.updateShowsView()
    }
    
    func setupCell(_ cell: BaseShowCell?,at index: Int) {
        cell?.setupWith(model: BaseShowInfoModel(score: nil, show: favoriteShowsList[index]))
    }
    
    func deleteFavoriteShowAt(index: Int) {
        interactor?.deleteShow(id: favoriteShowsList[index].id)
    }
    
    func totalFavoriteShows() -> Int {
        favoriteShowsList.count
    }
    
    func selectedEpisode(index: Int) {
        router?.routeToDetail(id: favoriteShowsList[index].id)
    }
}

extension FavoriteShowsListPresenter: FavoriteShowsListInteractorOutputProtocol {}
