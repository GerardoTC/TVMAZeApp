//
//  PinAuthenticationProtocols.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//
import UIKit

protocol PinAuthenticationInteractorProtocol: AnyObject {
    var presenter: PinAuthenticationInteractorOutputProtocol? { get set }
    func savePin(pin: String)
    func deletePin()
    func validatePin(pin: String) -> Bool
}

protocol PinAuthenticationPresenterProtocol: AnyObject {
    var view: PinAuthenticationViewProtocol? { get set }
    var router: PinAuthenticationRouterProtocol? { get set }
    var interactor: PinAuthenticationInteractorProtocol? { get set }
    var validationType: PinAuthenticationType? { get set }
    var result: PinDelegateResult? { get set }
    var currentPin: String? { get set }
    var hideCloseButton: Bool? { get set }
    
    func viewDidLoad()
    func endEditing(pin: String)
    func closePressed()
}

protocol PinAuthenticationInteractorOutputProtocol: AnyObject {
}

protocol PinAuthenticationRouterProtocol: BaseRouterWithError {
    var viewController: UIViewController? { get set }
    
    static func createPinAuthenticationModule(validationType: PinAuthenticationType, delegate: PinDelegateResult?, currentPin: String?, hideCloseButton: Bool) -> PinAuthenticationViewController?
    func routeToReEnterPin(_ delegate: PinDelegateResult?, _ currentPin: String?)
    func dismiss()
}

protocol PinAuthenticationViewProtocol: AnyObject {
    var presenter: PinAuthenticationPresenterProtocol? { get set }
    func updateTitle(_ title: String)
}
