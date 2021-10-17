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
        guard let initialViewController = ShowsSearchRouter.createShowsSearchModule() else { return }
        let navigationController = UINavigationController(rootViewController: initialViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.tintColor = .systemRed
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

