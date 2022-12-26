//
//  FavouritePostsRepository.swift
//  Navigation
//
//  Created by Filosuf on 02.12.2022.
//

import Foundation
import CoreData
import StorageService

final class FavouritePostsRepository {
    // MARK: - Properties
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "postStorageModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    static let shared = FavouritePostsRepository()

    // MARK: - Private Init
    private init() {}

    // MARK: - Methods
    func save(_ post: Post) {
        PostDataModel.create(with: post, using: persistentContainer.viewContext)
    }

    func getAllPosts() -> [Post] {
        let request = NSFetchRequest<PostDataModel>(entityName: "PostDataModel")
        guard let fetchRequestResult = try? persistentContainer.viewContext.fetch(request) else { return [] }
        return fetchRequestResult.map { $0.toPost() }
    }
}
