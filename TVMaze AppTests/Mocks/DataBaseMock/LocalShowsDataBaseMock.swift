//
//  DataBaseMock.swift
//  TVMaze AppTests
//
//  Created by Gerardo Tarazona Caceres on 20/10/21.
//

@testable import TVMaze_App

class LocalShowsDataBaseMock: LocalShowsDatabase {
    
    var showSavedMock: ShowInfoModel?
    var showDeletedMock: Bool?
    var showExistsMock: Bool?
    var allFavoriteShows: [ShowInfoModel]?
    var saveShowCalled = false
    var deleteShowCalled = false
    var showExistsCalled = false
    var getAllFavoriteShowsCalled = false
    
    func saveShow(_ show: ShowInfoModel) {
        showSavedMock = show
        saveShowCalled = true
    }
    
    func deleteShow(_ id: Int) -> Bool {
        deleteShowCalled = true
        return showDeletedMock ?? false
    }
    
    func showExists(_ id: Int) -> Bool {
        showExistsCalled = true
        return showExistsMock ?? false
    }
    
    func getAllFavoriteShows() -> Result<[ShowInfoModel], Error> {
        getAllFavoriteShowsCalled = true
        return .success(allFavoriteShows ?? [])
    }
    
    
}
