//
//  PinAuthenticationProtocols.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//
import UIKit

protocol PinAuthenticationInteractorProtocol: AnyObject {
    var presenter: PinAuthenticationInteractorOutputProtocol? { get set }
}

protocol PinAuthenticationPresenterProtocol: AnyObject {
    var view: PinAuthenticationViewProtocol? { get set }
    var router: PinAuthenticationRouterProtocol? { get set }
    var interactor: PinAuthenticationInteractorProtocol? { get set }
    
    func viewDidLoad()
}

protocol PinAuthenticationInteractorOutputProtocol: AnyObject {
}

protocol PinAuthenticationRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    
    static func createPinAuthenticationModule() -> PinAuthenticationViewController?
}

protocol PinAuthenticationViewProtocol: AnyObject {
    var presenter: PinAuthenticationPresenterProtocol? { get set }
}
