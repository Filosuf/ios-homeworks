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
    private let localAuthorizationService: LocalAuthorizationService

    init(loginFactory: LoginFactory, coordinator: ProfileFlowCoordinator, localAuthorizationService: LocalAuthorizationService) {
        self.loginInspector = loginFactory.makeLoginInspector()
        self.coordinator = coordinator
        self.localAuthorizationService = localAuthorizationService
    }

    func login(login: String, password: String) {
        do {
            try LoginInspector().checkCredentials(login: login, password: password) { [weak self] success in
                if success {
                    self?.coordinator.showProfile(userName: login)
                } else {
                    self?.coordinator.showAlert(title: "Error", message: "Пара Имя пользователя/Пароль не найдена")
                }
            }
        } catch LoginError.loginIsEmpty {
            coordinator.showAlert(title: "Ошибка", message: "Введите имя пользователя")
        } catch LoginError.passwordIsEmpty {
            coordinator.showAlert(title: "Ошибка", message: "Введите пароль")
        } catch {

        }
    }

    func signUp(login: String, password: String) {
        do {
            try LoginInspector().signUp(login: login, password: password) { [weak self] error in
                if error == nil {
                    self?.coordinator.showAlert(title: "", message: "Пользователь зарегестрирован")
                } else {
                    self?.coordinator.showAlert(title: "Error", message: "\(error?.localizedDescription)")
                }
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

    func biometricLogin() {
        localAuthorizationService.authorizeIfPossible { [weak self] result in
            switch result {
            case .success:
                self?.coordinator.showProfile(userName: "login2@bk.ru")
            case .failure(let error):
                self?.coordinator.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }

    func getBiometryType() -> Int {
        localAuthorizationService.getBiometryType()
    }
}
