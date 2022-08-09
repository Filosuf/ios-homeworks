//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by 1234 on 20.07.2022.
//

import Foundation
import UIKit

final class ProfileFlowCoordinator {

    private let controllersFactory: ControllersFactory
    let navCon: UINavigationController

    //MARK: - Initialiser
    init(navCon: UINavigationController, controllersFactory: ControllersFactory) {
        self.controllersFactory = controllersFactory
        self.navCon = navCon
    }

    func showProfile(userName: String) {
        let profileVC =  controllersFactory.makeProfileViewController(userName: userName, coordinator: self)
        navCon.pushViewController(profileVC, animated: true)
    }

    func showPhotos() {
        let vc = controllersFactory.makePhotoViewController()
        navCon.pushViewController(vc, animated: true)
    }

//    func pop(navCon: UINavigationController?) {
//        navCon?.popViewController(animated: true)
//    }
}
