//
//  LocalDataBase.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 19/10/21.
//

import Foundation

protocol LocalShowsDatabase {
    func saveShow(_ show: ShowInfoModel)
    @discardableResult
    func deleteShow(_ id: Int) -> Bool
    func showExists(_ id: Int) -> Bool
    func getAllFavoriteShows() -> Result<[ShowInfoModel], Error>
}

