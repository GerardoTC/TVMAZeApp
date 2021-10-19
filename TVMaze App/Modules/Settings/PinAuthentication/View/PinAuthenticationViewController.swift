//
//  PinAuthenticationViewController.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//
import UIKit

final class PinAuthenticationViewController: UIViewController, Storyboarded {
    
    var presenter: PinAuthenticationPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPresenterViewLoad()
    }
    
    func loadPresenterViewLoad() {
        presenter?.viewDidLoad()
    }
}

extension PinAuthenticationViewController: PinAuthenticationViewProtocol {}
