//
//  AppDelegate.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 15/10/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let tabBar = UITabBarController()
    let pinVC = PinAuthenticationRouter.createPinAuthenticationModule(validationType: .validate, delegate: nil, hideCloseButton: true)
    let appSettingsRouter = AppSettingsRouter()
    let secureStore = SecureStore()
    let authManager = AuthenticationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FontStyleRegister.registerFonts()
        setupFirstVC()
        return true
    }
    
    func setupFirstVC() {
        
        
        guard let showsListViewController = ShowsSearchRouter.createShowsSearchModule(),
              let appSettings = AppSettingsRouter.createAppSettingsModule()
        else { return }
        let navigationController = UINavigationController(rootViewController: showsListViewController)
        navigationController.navigationBar.tintColor = BaseColorPalette.accentColor.color
        navigationController.tabBarItem = UITabBarItem(title: "Shows", image: IconProvider.showsTabIcon.image, selectedImage: IconProvider.showsTabIcon.image)
        
        
        appSettings.tabBarItem = UITabBarItem(title: "Settings", image: IconProvider.appSettingsIcon.image, selectedImage: IconProvider.appSettingsIcon.image)
        tabBar.setViewControllers([navigationController, appSettings], animated: false)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.tintColor = BaseColorPalette.tintColor.color
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        if secureStore[SecureStoreKeys.pinValue.rawValue] != "",
            let pinVC = pinVC{
            handleBiometricsAuthIfNeeded()
            pinVC.modalPresentationStyle = .fullScreen
            tabBar.present(pinVC, animated: false, completion: nil)
        }
        updateDarkModeStyle()
    }
    
    private func updateDarkModeStyle() {
        DarkModeManager.updateDarkModeStatus(isOn: DefaultStore()[DefaultStoreKeys.darkModeOn.rawValue])
    }
    
    private func handleBiometricsAuthIfNeeded() {
        if secureStore[SecureStoreKeys.biometricsOn.rawValue] {
            authManager.delegate = self
            authManager.startBiometricAuthentication()
        }
    }
}

extension AppDelegate: BiometricAuthenticationManagerDelegate {
    func authenticationSuccess() {
        DispatchQueue.main.async {
            self.pinVC?.dismiss(animated: true, completion: nil)
        }
    }
    
    func authenticationFailed(error: BiometricAuthenticationError) {
        appSettingsRouter.viewController = pinVC
        appSettingsRouter.presentAlertError(error: error)
    }
}

