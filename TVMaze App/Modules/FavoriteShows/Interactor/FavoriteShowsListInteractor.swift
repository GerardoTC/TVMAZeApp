//
//  FavoriteShowsListInteractor.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 20/10/21.
//

final class FavoriteShowsListInteractor: FavoriteShowsListInteractorProtocol {
    weak var presenter: FavoriteShowsListInteractorOutputProtocol?
    var database: LocalShowsDatabase

    init(database: LocalShowsDatabase = LocalShowsDataController()) {
        self.database = database
    }
    
    func getAllFavoriteShows() -> [ShowInfoModel] {
        switch database.getAllFavoriteShows() {
        case .success(let shows):
            return shows
        case .failure(let error):
            print(error)
            return []
        }
    }
    
    func deleteShow(id: Int) {
        database.deleteShow(id)
    }
}
