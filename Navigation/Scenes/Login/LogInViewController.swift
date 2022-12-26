//
//  LogInViewController.swift
//  Navigation
//
//  Created by 1234 on 29.03.2022.
//

import UIKit
import SnapKit

protocol LoginViewControllerDelegate: AnyObject {

    func checkCredentials(login: String, password: String, success: @escaping (Bool) -> Void) throws
    func signUp(login: String, password: String, success: @escaping (Error?) -> Void) throws
}

final class LogInViewController: UIViewController {

    // MARK: - Properties
    private var viewModel: LoginViewModel
    private lazy var loginView = LoginView(delegate: self)

    // MARK: - Initialiser
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //очищаем поле пароля
        loginView.setPassword(password: "", isSecure: true)
        //default поле пароля
        loginView.setForDebug()
    }
    // MARK: - Metods
    private func layout() {
        view.addSubview(loginView)

        loginView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }

}

// MARK: - LoginViewDelegate
extension LogInViewController: LoginViewDelegate {

    func didTapSignUpButton() {
        let login = loginView.getLogin()
        let password = loginView.getPassword()

        viewModel.signUp(login: login, password: password)
    }

    func didTapLogInButton() {
        let login = loginView.getLogin()
        let password = loginView.getPassword()

        viewModel.login(login: login, password: password)
    }
}

// MARK: - Generate and Crack Password
extension LogInViewController {

    private func generatePassword(length: Int) -> String {
        let lettersAndNumbers: [String] = String().lettersAndNumbers.map { String($0) }
        var password = ""

        for _ in 1...length {
            password += lettersAndNumbers.randomElement()!
        }
        return password
    }

    func bruteForce(passwordToUnlock: String) {
        let lettersAndNumbers: [String] = String().lettersAndNumbers.map { String($0) }

        var password: String = ""

        // Will strangely ends at 0000 instead of ~~~
        while password != passwordToUnlock { // Increase MAXIMUM_PASSWORD_SIZE value for more
            password = generateBruteForce(password, fromArray: lettersAndNumbers)
            // Your stuff here
//            print(password)
            // Your stuff here
        }

//        print(password)
    }

}
