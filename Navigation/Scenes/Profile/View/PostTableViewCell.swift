//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by 1234 on 02.04.2022.
//

import UIKit
import StorageService
import iOSIntPackage

class PostTableViewCell: UITableViewCell {

    private let imageProcessor = ImageProcessor()
    private var post: Post?
    var likePostAction: ((Post) -> Void)?

    private let postAuthorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let postLikesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let postViewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .systemBackground
        layout()
        addLikePostGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addLikePostGesture() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(likePost))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
    }

    @objc
    private func likePost() {
        guard let post = post else { return }
        likePostAction?(post)
    }

    func setupCell(post: Post) {
        postAuthorLabel.text = post.author
        //add random filter for image
        if let image = UIImage(named: post.image) {
            let filter = ColorFilter.allCases[Int.random(in: 0..<ColorFilter.allCases.count)]
            ImageProcessor().processImage(sourceImage: image, filter: filter) {postImage.image = $0}
        }
        postDescriptionLabel.text = post.description
        postLikesLabel.text = "likes".localized + ": \(post.likes)"
        postViewsLabel.text = String(format: "views".localized, post.views)
        self.post = post
    }

    private func layout() {
        let spaceInterval: CGFloat = 16
        [postAuthorLabel, postImage, postDescriptionLabel, postLikesLabel, postViewsLabel].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            postAuthorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spaceInterval),
            postAuthorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spaceInterval),
            postAuthorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spaceInterval)
        ])
        
        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: postAuthorLabel.bottomAnchor, constant: spaceInterval),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: self.frame.width)
        ])

        NSLayoutConstraint.activate([
            postDescriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: spaceInterval),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spaceInterval),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spaceInterval)
        ])

        NSLayoutConstraint.activate([
            postLikesLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: spaceInterval),
            postLikesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spaceInterval),
            postLikesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spaceInterval)
        ])

        NSLayoutConstraint.activate([
            postViewsLabel.topAnchor.constraint(equalTo: postLikesLabel.topAnchor),
            postViewsLabel.leadingAnchor.constraint(equalTo: postLikesLabel.trailingAnchor),
            postViewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spaceInterval),
            postViewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spaceInterval),
            postViewsLabel.widthAnchor.constraint(equalTo: postLikesLabel.widthAnchor)
        ])
    }

}
