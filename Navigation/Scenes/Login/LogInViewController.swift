//
//  LogInViewController.swift
//  Navigation
//
//  Created by 1234 on 29.03.2022.
//

import UIKit
import SnapKit

protocol LoginViewControllerDelegate: AnyObject {

    func check(login: String, password: String) -> Bool
}

class LogInViewController: UIViewController {

    //MARK: - Properties
    
    lazy var loginView = LoginView(delegate: self)
    var delegate: LoginViewControllerDelegate?

    //MARK: - LifeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }

    //MARK: - Metods
    
    private func layout() {
        view.addSubview(loginView)

        loginView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }

}

//MARK: - LoginViewDelegate

extension LogInViewController: LoginViewDelegate {

    func didTapLogInButton() {
        let login = loginView.getLogin()
        guard let authorizationSuccessful = delegate?.check(login: login, password: loginView.getPassword()) else {
                   print("File:" + #file, "\nFunction: " + #function + "\nError message: Не удалось выполнить проверку пары Логин/Пароль\n")
                   return
               }
               #if DEBUG
                   let userService = TestUserService()
               #else
                   let userService = CurrentUserService()
               #endif
               let vc = ProfileViewController(userService: userService, userName: login)
               if authorizationSuccessful {
                   navigationController?.pushViewController(vc, animated: true)
               } else {
                   print("File:" + #file, "\nFunction: " + #function + "\nError message: Пара Логин/Пароль не найдена\n")
               }
    }


}
