//
//  DarkModeManager.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

import UIKit

class DarkModeManager {
    static func updateDarkModeStatus(isOn: Bool) {
        if let window = UIApplication.shared.windows.first {
            UIView.transition (with: window,
                               duration: 0.3,
                               options: .transitionCrossDissolve,
                               animations: {
                                window.overrideUserInterfaceStyle = isOn ? .dark : .light
                               })
        }
    }
}
