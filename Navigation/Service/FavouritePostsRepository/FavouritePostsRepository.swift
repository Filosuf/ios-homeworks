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
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    static let shared = FavouritePostsRepository()

    // MARK: - Private Init
    private init() {}

    // MARK: - Methods
    func save(_ post: Post) {
        persistentContainer.performBackgroundTask { contextBackground in
            if self.getPost(image: post.image, context: contextBackground) != nil { return }
            PostDataModel.create(with: post, using: contextBackground)
        }
    }

    func getPosts(author: String? = nil) -> [Post] {
        let request = PostDataModel.fetchRequest()
        if let author = author, author != ""  {
            request.predicate = NSPredicate(format: "author contains[c] %@", author)
        }
        guard let fetchRequestResult = try? persistentContainer.viewContext.fetch(request) else { return [] }
        return fetchRequestResult.map { $0.toPost() }
    }

    func getPost(image: String, context: NSManagedObjectContext) -> PostDataModel? {
        let request = PostDataModel.fetchRequest()
        request.predicate = NSPredicate(format: "image == %@", image)
        return (try? context.fetch(request))?.first
    }

    func deleteObject(_ post: Post) {
        let context = persistentContainer.viewContext

        if let post = getPost(image: post.image, context: context) {
            context.delete(post)
            saveContext()
        }
    }

    func deleteObject(_ post: PostDataModel) {
        let context = persistentContainer.viewContext
        context.delete(post)
        saveContext()
    }

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
               let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
