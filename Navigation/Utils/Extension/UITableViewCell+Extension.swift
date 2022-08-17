//
//  UITableViewCell+Extension.swift
//  Navigation
//
//  Created by 1234 on 08.04.2022.
//

import UIKit

extension UITableViewCell {
    
    func makeImageView(imageName: String) -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(named: imageName)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }
}
