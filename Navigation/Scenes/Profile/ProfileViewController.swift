//
//  ProfileViewController.swift
//  Navigation
//
//  Created by 1234 on 06.03.2022.
//


import UIKit
import StorageService
import FirebaseAuth

final class ProfileViewController: UIViewController {

    //MARK: - Properties
    
    let myPosts = Post.makeArrayPosts()
    private weak var coordinator: ProfileFlowCoordinator?
    private let userService: UserService
    private let userName: String

    private lazy var profileHeaderView = ProfileHeaderView(delegate: self)

    static let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.dataSource = self
//        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        return tableView
    }()

    //MARK: - LifeCicle
    init(userService: UserService, userName: String, coordinator: ProfileFlowCoordinator) {
        self.userService = userService
        self.userName = userName
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        #if DEBUG
            view.backgroundColor = .white
        #else
            view.backgroundColor = .white
        #endif
        setTableView()
        loadUser(userName: userName)
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    //MARK: - Methods
    func setTableView() {
        ProfileViewController.tableView.dataSource = self
        ProfileViewController.tableView.delegate = self
    }

    private func loadUser(userName: String) {
        userService.getUser(userName: userName) { result in
            switch result {
            case .success(let user):
                profileHeaderView.setupView(user: user)
            case .failure(let error):
                hundle(error: error)
            }
        }
    }

    private func hundle(error: UserGetError) {
        switch error{
        case .notFound: fatalError()
        case .unowned: print("File:" + #file, "\nFunction: " + #function + "\nUserGetError.unowned\n")
        }
    }

    private func layout() {
        [ProfileViewController.tableView].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([

            ProfileViewController.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ProfileViewController.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ProfileViewController.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ProfileViewController.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        }
        return myPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.setupCell(post: myPosts[indexPath.row])
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
}
//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return profileHeaderView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            coordinator?.showPhotos()
        }
    }
}

//MARK: - ProfileHeaderViewDelegate, FirebaseAuth
extension ProfileViewController: ProfileHeaderViewDelegate {
    func didTapLogoutButton() {
        Checker.shared.deleteLogin()
        coordinator?.pop()
    }
}
