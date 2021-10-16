//
//  ShowsSearchPresenter.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

final class ShowsSearchPresenter: ShowsSearchPresenterProtocol {
    
    weak var view: ShowsSearchViewProtocol?
    var router: ShowsSearchRouterProtocol?
    var interactor: ShowsSearchInteractorProtocol?
    
    func viewDidLoad() {}
}

extension ShowsSearchPresenter: ShowsSearchInteractorOutputProtocol {}
