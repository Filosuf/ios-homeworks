//
//  FeedFlowCoordinator.swift
//  Navigation
//
//  Created by 1234 on 21.07.2022.
//

import Foundation
import UIKit

final class FeedFlowCoordinator {

    private let controllersFactory: ControllersFactory
    let navCon: UINavigationController
    
    //MARK: - Initialiser
    init(navCon: UINavigationController, controllersFactory: ControllersFactory) {
        self.controllersFactory = controllersFactory
        self.navCon = navCon
    }
    
    func showPost(title: String) {
        let vc = PostViewController()
        vc.title = title
        navCon.pushViewController(vc, animated: true)
    }
    
}
