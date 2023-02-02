//
//  FavoritePostsViewController.swift
//  Navigation
//
//  Created by Filosuf on 01.12.2022.
//

import UIKit
import StorageService
import CoreData

class FavoritePostsViewController: UIViewController, NSFetchedResultsControllerDelegate {

    //MARK: - Properties

    let fetchResultController: NSFetchedResultsController<PostDataModel> = {
        let fetchRequest = PostDataModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "likes", ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                               managedObjectContext: FavouritePostsRepository.shared.persistentContainer.viewContext,
                                                               sectionNameKeyPath: nil,
                                                               cacheName: nil)
        return frc
    }()

    private var myPosts = [Post]()
    private let favouritePostsRepository = FavouritePostsRepository.shared
    private let searchController = UISearchController(searchResultsController: nil)

    fileprivate lazy var tableView: UITableView = {
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
        view.backgroundColor = .white
        title = "like".localized
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        layout()
        fetchResultController.delegate = self
        try? fetchResultController.performFetch()
    }

    //MARK: - Methods
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        @unknown default:
            tableView.reloadData()
        }
        tableView.reloadData()
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
extension FavoritePostsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        myPosts = favouritePostsRepository.getPosts(author: searchController.searchBar.text)
        tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource
extension FavoritePostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultController.sections?[section].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        let postViewModel = fetchResultController.object(at: indexPath).toPost()
        cell.setupCell(post: postViewModel)
        return cell
    }
}
//MARK: - UITableViewDelegate
extension FavoritePostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete".localized) { [weak self] (contextualAction, view, boolValue) in

            guard let self = self else { return }
            let post = self.fetchResultController.object(at: indexPath)
            self.favouritePostsRepository.deleteObject(post)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])

        return swipeActions
    }
}
