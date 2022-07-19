//
//  Photo.swift
//  Navigation
//
//  Created by 1234 on 21.06.2022.
//

import Foundation
import UIKit

struct Photo {
    let imageName: String
    let photo: UIImage

    static func makeArrayPhotos() -> [Photo] {
        var names = [Photo]()
        for index in 1...20 {
            names.append(Photo(imageName: "\(index)", photo: UIImage(named: "\(index)")!))
        }
        return names
    }

    static func makeArrayImages() -> [UIImage] {
        var images = [UIImage]()
        for index in 1...20 {
            images.append(UIImage(named: "\(index)")!)
        }
        return images
    }
}
