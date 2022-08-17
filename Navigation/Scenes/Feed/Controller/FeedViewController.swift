//
//  FeedViewController.swift
//  Navigation
//
//  Created by 1234 on 06.03.2022.
//

import UIKit
import StorageService
import SnapKit

class FeedViewController: UIViewController {

    //MARK: - Properties
    let model: FeedModel
    var post = Post(title: "Заголовок поста")
    lazy var feedView = FeedView(delegate: self)
    private var coordinator: FeedFlowCoordinator?

    //MARK: - LifeCicle
    init(model: FeedModel, coordinator: FeedFlowCoordinator) {
        self.model = model
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAction), name: .updateIsValidWord, object: nil)
        layout()
    }

    //MARK: - Metods
    @objc private func notificationAction(_ notification: Notification) {
        guard let result = notification.object as? Bool else {
            let object = notification.object as Any
            assertionFailure("Invalid object: \(object)")
            return
        }
        print("Set IsValid")
        feedView.setResultLabel(result: result)
    }

    private func layout() {
        view.addSubview(feedView)

        feedView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }

}

//MARK: - FeedViewDelegate
extension FeedViewController: FeedViewDelegate {

   func didTapPostButton() {
        coordinator?.showPost(title: post.title)
    }

    func check(word: String) {
        model.check(word: word)
    }
}
