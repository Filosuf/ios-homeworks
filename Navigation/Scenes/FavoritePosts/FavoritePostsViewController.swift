//
//  FavoritePostsViewController.swift
//  Navigation
//
//  Created by Filosuf on 01.12.2022.
//

import UIKit
import StorageService
class FavoritePostsViewController: UIViewController {

    //MARK: - Properties

    private var myPosts = [Post]() { didSet {
        tableView.reloadData() } }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        return tableView
    }()

    //MARK: - LifeCicle
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FavoritePosts"
        view.backgroundColor = .white
        getPosts()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPosts()
//        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    //MARK: - Methods

    private func getPosts() {
        myPosts = FavouritePostsRepository.shared.getAllPosts()
    }

    private func layout() {
        [tableView].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDataSource
extension FavoritePostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.setupCell(post: myPosts[indexPath.row])
        return cell
    }

//    func numberOfSections(in tableView: UITableView) -> Int {
//        2
//    }
}
//MARK: - UITableViewDelegate
extension FavoritePostsViewController: UITableViewDelegate {

}
