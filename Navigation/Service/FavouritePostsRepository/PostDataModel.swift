//
//  PostDataModel.swift
//  Navigation
//
//  Created by Filosuf on 11.12.2022.
//

import CoreData
import StorageService

extension PostDataModel {
//    @NSManaged var author: String
//    @NSManaged var descript: String
//    @NSManaged var image: String
//    @NSManaged var likes: Int64
//    @NSManaged var views: Int64

    static func create(with post: Post, using context: NSManagedObjectContext) {
        let postDataModel = PostDataModel(context: context)
        postDataModel.title = post.title
        postDataModel.author = post.author
        postDataModel.descript = post.description
        postDataModel.image = post.image
        postDataModel.likes = Int64(post.likes)
        postDataModel.views = Int64(post.views)

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func toPost() -> Post {
        Post(
            author: author ?? "",
            description: descript ?? "",
            image: image ?? "",
            likes: Int(likes),
            views: Int(views)
        )
    }
}
