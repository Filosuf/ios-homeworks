//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by 1234 on 02.04.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    private let postAuthorLabel: UILabel = {

        let label = UILabel()
        label.textColor = .black
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
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let postViewsLabel: UILabel = {

        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(post: Post) {
        postAuthorLabel.text = post.author
        postImage.image = UIImage(named: post.image)
        postDescriptionLabel.text = post.description
        postLikesLabel.text = "Likes: \(post.likes)"
        postViewsLabel.text = "Views: \(post.views)"
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
