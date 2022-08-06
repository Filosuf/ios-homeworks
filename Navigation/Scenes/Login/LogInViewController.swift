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

final class LogInViewController: UIViewController {

    //MARK: - Properties
    private var viewModel: LoginViewModel
    private lazy var loginView = LoginView(delegate: self)

    //MARK: - Initialiser
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        let password = loginView.getPassword()

        viewModel.login(login: login, password: password)
    }


}
