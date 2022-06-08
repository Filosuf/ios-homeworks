//
//  Photo.swift
//  Navigation
//
//  Created by 1234 on 07.04.2022.
//

import UIKit

struct Photo {
    let imageName: String

    static func makeArrayPhotos() -> [Photo] {
        var photos = [Photo]()
        for index in 1...20 {
            photos.append(Photo(imageName: "\(index)"))
        }
        return photos
    }

}
