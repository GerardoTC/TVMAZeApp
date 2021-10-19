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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FontStyleRegister.registerFonts()
        setupFirstVC()
        return true
    }
    
    func setupFirstVC() {
        let tabBar = UITabBarController()
        
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
        updateDarkModeStyle()
    }
    
    private func updateDarkModeStyle() {
        DarkModeManager.updateDarkModeStatus(isOn: DefaultStore()[DefaultStoreKeys.darkModeOn.rawValue])
    }
}

