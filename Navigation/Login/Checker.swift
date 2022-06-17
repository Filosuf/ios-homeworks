//
//  Checker.swift
//  Navigation
//
//  Created by 1234 on 14.06.2022.
//

import Foundation

class Checker {

    static let shared = Checker()

    private let login = "login"
    private let password = "qwerty"

    private init() {}

    func authorization(login: String, password: String) -> Bool {
        return self.login.hash == login.hash && self.password.hash == password.hash
    }
}
