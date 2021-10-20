//
//  LocalBiometricAuthentication.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 19/10/21.
//
import LocalAuthentication

protocol LocalBiometricAuthenticationManager: AnyObject {
    var delegate: BiometricAuthenticationManagerDelegate? { get set }
    func startBiometricAuthentication()
}

class AuthenticationManager: LocalBiometricAuthenticationManager {
    weak var delegate: BiometricAuthenticationManagerDelegate?
    
    private var context = LAContext()
    
    func startBiometricAuthentication() {
        var error: NSError? = nil
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            if let error = error {
                self.handleAuthenticationWithBiometrics(LAError(_nsError: error))
                return
            }
            delegate?.authenticationFailed(error: .biometricNotConfigured)
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Biometric Authentication is required to unlock the app") { [weak self] (success, error) in
            if let error = error {
                self?.handleAuthenticationWithBiometrics(error)
                return
            }
            self?.delegate?.authenticationSuccess()
        }
    }
    
    func handleAuthenticationWithBiometrics(_ error: Error) {
        switch error {
        case LAError.invalidContext:
            context.invalidate()
            context = LAContext()
            startBiometricAuthentication()
        case LAError.biometryLockout:
            delegate?.authenticationFailed(error: .biometricLockout)
        case LAError.userCancel, LAError.systemCancel:
            delegate?.authenticationFailed(error: .canceled)
        case LAError.userFallback:
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Enter your pinToProceed") { [weak self] (success, error) in
                if success {
                    self?.delegate?.authenticationSuccess()
                } else {
                    self?.delegate?.authenticationFailed(error: .failed)
                }
            }
        case LAError.authenticationFailed:
            delegate?.authenticationFailed(error: .failed)
        default:
            delegate?.authenticationFailed(error: .biometricNotConfigured)
        }
    }
    
}

enum BiometricAuthenticationError: Error, LocalizedError {
    case canceled
    case failed
    case biometricLockout
    case biometricNotConfigured
}

protocol BiometricAuthenticationManagerDelegate: AnyObject {
    func authenticationSuccess()
    func authenticationFailed(error: BiometricAuthenticationError)
}
