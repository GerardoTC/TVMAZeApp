//
//  ShowsSearchProtocols.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//
import UIKit

protocol ShowsSearchInteractorProtocol: AnyObject {
    var presenter: ShowsSearchInteractorOutputProtocol? { get set }
}

protocol ShowsSearchPresenterProtocol: AnyObject {
    var view: ShowsSearchViewProtocol? { get set }
    var router: ShowsSearchRouterProtocol? { get set }
    var interactor: ShowsSearchInteractorProtocol? { get set }
    
    func viewDidLoad()
}

protocol ShowsSearchInteractorOutputProtocol: AnyObject {
}

protocol ShowsSearchRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    
    static func createShowsSearchModule() -> ShowsSearchViewController?
}

protocol ShowsSearchViewProtocol: AnyObject {
    var presenter: ShowsSearchPresenterProtocol? { get set }
}
