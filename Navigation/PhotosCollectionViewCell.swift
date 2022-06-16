//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by 1234 on 07.04.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    private let photoImage: UIImageView = {

        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(photo: UIImage) {
        photoImage.image = photo
    }

    private func layout() {
        [photoImage].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            photoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
