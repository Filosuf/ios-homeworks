//
//  MainCoordinator.swift
//  Navigation
//
//  Created by 1234 on 19.07.2022.
//

import Foundation

import Foundation
import UIKit

enum TabBarPage {
    case feed
    case profile
    case favoritePosts

    var pageTitle: String {
        switch self {
        case .feed:
            return "feed".localized
        case .profile:
            return "profile".localized
        case .favoritePosts:
            return "like".localized
        }
    }

    var image: UIImage? {
        switch self {
        case .feed:
            return UIImage(systemName: "list.bullet")
        case .profile:
            return UIImage(systemName: "person.crop.circle")
        case .favoritePosts:
            return UIImage(systemName: "heart")
        }
    }
}

protocol MainCoordinator {
    func startApplication(userEmail: String?) -> UIViewController
}

final class MainCoordinatorImp: MainCoordinator {

    private let controllersFactory = ControllersFactory()
    private var userEmail: String?

    // проверка авторизован ли юзер
    // показать либо экран авторизации, либо новостную ленту
    func startApplication(userEmail: String?) -> UIViewController {
        self.userEmail = userEmail
        return getTabBarController()
    }

    //MARK: - Metods
    private func getTabBarController() -> UIViewController {
        let tabBarVC = MainTabBarController()
        let pages: [TabBarPage] = [.feed, .profile, .favoritePosts]

        tabBarVC.setViewControllers(pages.map { getNavController(page: $0) }, animated: true)
        return tabBarVC
    }

    private func getNavController(page: TabBarPage) -> UINavigationController {
        let navigationVC = UINavigationController()
        navigationVC.tabBarItem.image = page.image
        navigationVC.tabBarItem.title = page.pageTitle

        switch page {
        case .feed:
            let feedChildCoordinator = FeedFlowCoordinator(navCon: navigationVC, controllersFactory: controllersFactory)
            let feedVC = controllersFactory.makeFeedViewController(coordinator: feedChildCoordinator)
            navigationVC.pushViewController(feedVC, animated: true)
        case .profile:
            let profileChildCoordinator = ProfileFlowCoordinator(navCon: navigationVC, controllersFactory: controllersFactory)
            let logInVC = controllersFactory.makeLoginViewController(coordinator: profileChildCoordinator)
            navigationVC.pushViewController(logInVC, animated: true)
            //открываем экран профиля, если пользователь авторизован
            if let userEmail = userEmail {
                let profileVC =  controllersFactory.makeProfileViewController(
                    userName: userEmail,
                    coordinator: profileChildCoordinator
                )
                navigationVC.pushViewController(profileVC, animated: true)
            }
        case .favoritePosts:
            let favoritePostsVC = controllersFactory.makeFavoritePostsVC()
            navigationVC.pushViewController(favoritePostsVC, animated: true)
        }

        return navigationVC
    }
}
