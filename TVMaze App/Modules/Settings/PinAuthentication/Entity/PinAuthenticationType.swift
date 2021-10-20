//
//  PinAuthenticationType.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 19/10/21.
//

import Foundation

enum PinAuthenticationType {
    var title: String {
        switch self {
        case .registerPin:
            return "Register your PIN"
        case .reEnterPin:
            return "Re Enter your PIN"
        case .validate:
            return "Enter your PIN"
        case .disablePin:
            return "Enter your PIN to disable it"
        
        }
    }
    case registerPin
    case reEnterPin
    case validate
    case disablePin
}

protocol PinDelegateResult: AnyObject {
    func handlePinEndValidation()
}

enum PinAuthenticationResult {
    case successValidation
    case cancel
    case cancelRegistration
}
