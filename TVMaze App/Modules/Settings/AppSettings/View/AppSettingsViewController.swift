//
//  AppSettingsViewController.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//
import UIKit

final class AppSettingsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var pinTitle: UILabel!
    @IBOutlet weak var pinSwitch: UISwitch!
    @IBOutlet weak var biometricsSwitch: UISwitch!
    @IBOutlet weak var biometricsTitle: UILabel!
    @IBOutlet weak var darkModeTitle: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    var presenter: AppSettingsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPresenterViewLoad()
        setupUIView()
    }
    
    func loadPresenterViewLoad() {
        presenter?.viewDidLoad()
    }
    
    private func setupUIView() {
        pinTitle.setFont(.bodyL)
        biometricsTitle.setFont(.bodyL)
        darkModeTitle.setFont(.bodyL)
        darkModeSwitch.onTintColor = BaseColorPalette.tintColor.color
        pinSwitch.onTintColor = BaseColorPalette.tintColor.color
        biometricsSwitch.onTintColor = BaseColorPalette.tintColor.color
    }
    
    @IBAction func pinValueChanged(_ sender: Any) {
        presenter?.pinStatusChanged(pinSwitch.isOn)
    }
    
    @IBAction func biometricsValueChanged(_ sender: Any) {
        presenter?.biometricsStatusChanged(biometricsSwitch.isOn)
    }
    
    @IBAction func darkModeValueChanged(_ sender: Any) {
        presenter?.darkModeStatusChanged(darkModeSwitch.isOn)
        DarkModeManager.updateDarkModeStatus(isOn: darkModeSwitch.isOn)
    }

}

extension AppSettingsViewController: AppSettingsViewProtocol {
    func updateSwitchesInfo(_ pinStatus: Bool, _ biometricsStatus: Bool, _ darkModeStatus: Bool) {
        pinSwitch.isOn = pinStatus
        biometricsSwitch.isOn = biometricsStatus
        darkModeSwitch.isOn = darkModeStatus
        DarkModeManager.updateDarkModeStatus(isOn: darkModeSwitch.isOn)
    }
}
