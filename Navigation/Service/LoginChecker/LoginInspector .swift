//
//  LoginInspector .swift
//  Navigation
//
//  Created by 1234 on 14.06.2022.
//

import Foundation

enum LoginError: Error {
    case loginIsEmpty
    case loginIsIncorrect
    case passwordIsEmpty
    case passwordIsIncorrect
    case isInvalid
}

class LoginInspector: LoginViewControllerDelegate {

    func check(login: String, password: String) throws -> Bool {

        let pairIsValid = Checker.shared.authorization(login: login, password: password)

        switch (login, password) {
        case ("", _):
            throw LoginError.loginIsEmpty
        case (_, ""):
            throw LoginError.passwordIsEmpty
        default:
            break
        }
        if pairIsValid == false {
            throw LoginError.isInvalid
        }

        return pairIsValid
    }

    
}
