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
        do {
            let authorizationSuccessful = try LoginInspector().check(login: login, password: password)
            if authorizationSuccessful {
                coordinator.showProfile(userName: login)
            }
        } catch LoginError.loginIsEmpty {
            coordinator.showAlert(title: "Ошибка", message: "Введите имя пользователя")
        } catch LoginError.passwordIsEmpty {
            coordinator.showAlert(title: "Ошибка", message: "Введите пароль")
        } catch LoginError.isInvalid {
            coordinator.showAlert(title: "Error", message: "Пара Имя пользователя/Пароль не найдена")
            print("File:" + #file, "\nFunction: " + #function + "\nError message: Пара Логин/Пароль не найдена\n")
        } catch {

        }
    }


}
