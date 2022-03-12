//
//  FeedViewController.swift
//  Navigation
//
//  Created by 1234 on 06.03.2022.
//

import UIKit

class FeedViewController: UIViewController {

    var post = Post(title: "Заголовок поста")
    

    private let postButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Feed"

        postButton.setTitle("Post", for: .normal)
        view.addSubview(postButton)
        postButton.backgroundColor = .systemGray
        postButton.setTitleColor(.black, for: .normal)
        postButton.frame = CGRect(x: 100, y: 100, width: 200, height: 52)
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
    }

    @objc private func didTapPostButton() {

        let vc = PostViewController()
        vc.title = post.title
        navigationController?.pushViewController(vc, animated: true)
    }


}
