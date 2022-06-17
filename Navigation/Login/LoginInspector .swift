//
//  LoginInspector .swift
//  Navigation
//
//  Created by 1234 on 14.06.2022.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {

    func check(login: String, password: String) -> Bool {
        return Checker.shared.authorization(login: login, password: password)
    }

    
}
