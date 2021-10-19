//
//  PinAuthenticationPresenter.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

final class PinAuthenticationPresenter: PinAuthenticationPresenterProtocol {
    
    weak var view: PinAuthenticationViewProtocol?
    var router: PinAuthenticationRouterProtocol?
    var interactor: PinAuthenticationInteractorProtocol?
    
    func viewDidLoad() {}
}

extension PinAuthenticationPresenter: PinAuthenticationInteractorOutputProtocol {}
