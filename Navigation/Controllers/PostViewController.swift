//
//  PostViewController.swift
//  Navigation
//
//  Created by 1234 on 06.03.2022.
//

import UIKit

class PostViewController: UIViewController, PostDelegate {

    weak var delegate: PostDelegate?
    
    var post = Post()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemMint

        if let temp = delegate?.post {
            post = temp
        }
        title = post.title

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(dismissSelf))

    }
    
    @objc private func dismissSelf() {
        let navVC = UINavigationController(rootViewController: InfoViewController())
        present(navVC, animated: true)
    }

}
