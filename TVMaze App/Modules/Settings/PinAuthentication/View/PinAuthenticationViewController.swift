//
//  PinAuthenticationViewController.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//
import UIKit

final class PinAuthenticationViewController: UIViewController, Storyboarded {
    
    var presenter: PinAuthenticationPresenterProtocol?
    
    @IBOutlet weak var pinTitle: UILabel!
    @IBOutlet weak var pinInput: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPresenterViewLoad()
        setupUIView()
    }
    
    func loadPresenterViewLoad() {
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        focusTextField()
    }
    
    @IBAction func closePressed(_ sender: Any) {
        presenter?.closePressed()
    }
    
    func setupUIView() {
        pinInput.delegate = self
        pinInput.returnKeyType = .done
        pinInput.isSecureTextEntry = true
        closeButton.isHidden = presenter?.hideCloseButton ?? false
    }
}

extension PinAuthenticationViewController: PinAuthenticationViewProtocol {
    func updateTitle(_ title: String) {
        pinTitle.text = title
    }
    
    func focusTextField() {
        pinInput.becomeFirstResponder()
    }
}

extension PinAuthenticationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let pin = pinInput.text else {
            return false
        }
        presenter?.endEditing(pin: pin)
        return true
    }
}
