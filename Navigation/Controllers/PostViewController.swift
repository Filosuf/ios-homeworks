//
//  PostViewController.swift
//  Navigation
//
//  Created by 1234 on 06.03.2022.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "info.circle"), style: .plain, target: self, action: #selector(dismissSelf))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(dismissSelf))

    }
    
    @objc private func dismissSelf() {
        let navVC = UINavigationController(rootViewController: InfoViewController())
        present(navVC, animated: true)
    }

}
