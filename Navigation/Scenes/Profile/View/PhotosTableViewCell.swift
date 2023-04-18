//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by 1234 on 05.04.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    private let photosLabel: UILabel = {
        let label = UILabel()
        label.text = "photos".localized
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let goToGalleryButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrow.forward"), for: .normal)
        button.tintColor = .createColor(lightMode: .black, darkMode: .white)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var galleryImageFirst = makeImageView(imageName: "1")
    private lazy var galleryImageSecond = makeImageView(imageName: "2")
    private lazy var galleryImageThird = makeImageView(imageName: "3")
    private lazy var galleryImageFourth = makeImageView(imageName: "4")

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        goToGalleryButton.tintColor = .createColor(lightMode: .black, darkMode: .white)
    }

    private func layout() {
        let basicSpaceInterval: CGFloat = 12
        [photosLabel, goToGalleryButton, galleryImageFirst, galleryImageSecond, galleryImageThird, galleryImageFourth].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: basicSpaceInterval),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: basicSpaceInterval),

            goToGalleryButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            goToGalleryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -basicSpaceInterval),
            goToGalleryButton.widthAnchor.constraint(equalTo: goToGalleryButton.heightAnchor),
            goToGalleryButton.heightAnchor.constraint(equalTo: photosLabel.heightAnchor),

            galleryImageFirst.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: basicSpaceInterval),
            galleryImageFirst.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: basicSpaceInterval),
            galleryImageFirst.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 5 * basicSpaceInterval) / 4),
            galleryImageFirst.heightAnchor.constraint(equalTo: galleryImageFirst.widthAnchor),
            galleryImageFirst.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -basicSpaceInterval),

            galleryImageSecond.topAnchor.constraint(equalTo: galleryImageFirst.topAnchor),
            galleryImageSecond.leadingAnchor.constraint(equalTo: galleryImageFirst.trailingAnchor, constant: basicSpaceInterval),
            galleryImageSecond.widthAnchor.constraint(equalTo: galleryImageFirst.widthAnchor),
            galleryImageSecond.heightAnchor.constraint(equalTo: galleryImageFirst.heightAnchor),

            galleryImageThird.topAnchor.constraint(equalTo: galleryImageFirst.topAnchor),
            galleryImageThird.leadingAnchor.constraint(equalTo: galleryImageSecond.trailingAnchor, constant: basicSpaceInterval),
            galleryImageThird.widthAnchor.constraint(equalTo: galleryImageFirst.widthAnchor),
            galleryImageThird.heightAnchor.constraint(equalTo: galleryImageFirst.heightAnchor),

            galleryImageFourth.topAnchor.constraint(equalTo: galleryImageFirst.topAnchor),
            galleryImageFourth.leadingAnchor.constraint(equalTo: galleryImageThird.trailingAnchor, constant: basicSpaceInterval),
            galleryImageFourth.widthAnchor.constraint(equalTo: galleryImageFirst.widthAnchor),
            galleryImageFourth.heightAnchor.constraint(equalTo: galleryImageFirst.heightAnchor),
        ])
    }

}
