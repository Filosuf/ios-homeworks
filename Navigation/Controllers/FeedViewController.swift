//
//  FeedViewController.swift
//  Navigation
//
//  Created by 1234 on 06.03.2022.
//

import UIKit

class FeedViewController: UIViewController {

    var post = Post(title: "Заголовок поста")

    private let buttonVerticalStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10

        return stackView
    }()

    private let postButtonFirst: UIButton = {

        let button = UIButton()
        button.setTitle("Post #1", for: .normal)
        button.backgroundColor = .systemGray
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let postButtonSecond: UIButton = {

        let button = UIButton()
        button.setTitle("Post #2", for: .normal)
        button.backgroundColor = .systemGray
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Feed"

        view.addSubview(buttonVerticalStackView)
        buttonVerticalStackView.addArrangedSubview(postButtonFirst)
        buttonVerticalStackView.addArrangedSubview(postButtonSecond)
        constraints()
    }

    @objc private func didTapPostButton() {

        let vc = PostViewController()
        vc.title = post.title
        navigationController?.pushViewController(vc, animated: true)
    }

    private func constraints() {

        NSLayoutConstraint.activate([
            buttonVerticalStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            buttonVerticalStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            buttonVerticalStackView.widthAnchor.constraint(equalToConstant: 200),
            buttonVerticalStackView.heightAnchor.constraint(equalToConstant: 52 * 2 + 10)
        ])

    }

}
