//
//  LoginViewModel.swift
//  Navigation
//
//  Created by 1234 on 06.08.2022.
//

import Foundation
import UIKit

final class LoginViewModel {
    private let loginInspector: LoginInspector
    private let coordinator: ProfileFlowCoordinator

    init(loginFactory: LoginFactory, coordinator: ProfileFlowCoordinator) {
        self.loginInspector = loginFactory.makeLoginInspector()
        self.coordinator = coordinator
    }

    func login(login: String, password: String) {
        let authorizationSuccessful = LoginInspector().check(login: login, password: password)
        if authorizationSuccessful {
            coordinator.showProfile(userName: login)
        } else {
            print("File:" + #file, "\nFunction: " + #function + "\nError message: Пара Логин/Пароль не найдена\n")
        }
        
    }
}
