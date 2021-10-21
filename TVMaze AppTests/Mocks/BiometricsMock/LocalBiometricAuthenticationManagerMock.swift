//
//  LocalBiometricAuthenticationManagerMock.swift
//  TVMaze AppTests
//
//  Created by Gerardo Tarazona Caceres on 20/10/21.
//

@testable import TVMaze_App

class LocalBiometricAuthenticationManagerMock: LocalBiometricAuthenticationManager {
    var delegate: BiometricAuthenticationManagerDelegate?
    var success: Bool = false
    var error: BiometricAuthenticationError = .canceled
    
    func startBiometricAuthentication() {
        if success {
            delegate?.authenticationSuccess()
        } else {
            delegate?.authenticationFailed(error: error)
        }
    }
}
