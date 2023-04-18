//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Filosuf on 15.03.2023.
//

import Foundation
import LocalAuthentication

enum LocalAuthorizationError: Error {
    case authenticationFailed
    case userCancel
    case userFallback
    case systemCancel
    case passcodeNotSet
    case touchIDNotAvailable
    case touchIDNotEnrolled
    case touchIDLockout
    case appCancel
    case invalidContext
    case notInteractive
    case unknown
}

final class LocalAuthorizationService {
    // MARK: - Properties
    private var context = LAContext()

    // MARK: - Methods
    func authorizeIfPossible(_ authorizationFinished: @escaping (Result<Bool,LocalAuthorizationError>) -> Void) {
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            print(error?.localizedDescription ?? "Can't evaluate policy")

            // Fall back to a asking for username and password.
            // ...
            return
        }

        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate to proceed.") { (success, error) in
            if success {
                DispatchQueue.main.async {
                    authorizationFinished(.success(success))
                }
            } else {
                var customError = LocalAuthorizationError.unknown
                if let error = error as? LAError {
                    switch error.code {
                    case .authenticationFailed:
                        customError = .authenticationFailed
                    case .userCancel:
                        customError = .userCancel
                    case .userFallback:
                        customError = .userFallback
                    case .systemCancel:
                        customError = .systemCancel
                    case .passcodeNotSet:
                        customError = .passcodeNotSet
                    case .touchIDNotAvailable:
                        customError = .touchIDNotAvailable
                    case .touchIDNotEnrolled:
                        customError = .touchIDNotEnrolled
                    case .touchIDLockout:
                        customError = .touchIDLockout
                    case .appCancel:
                        customError = .appCancel
                    case .invalidContext:
                        customError = .invalidContext
                    case .notInteractive:
                        customError = .notInteractive
                    @unknown default:
                        customError = .unknown
                    }
                }
                DispatchQueue.main.async {
                    authorizationFinished(.failure(customError))
                }
            }
        }
    }

    func getBiometryType() -> Int {
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) else {
            return 0
        }
        let biometryType = context.biometryType
        return biometryType.rawValue
    }
}
