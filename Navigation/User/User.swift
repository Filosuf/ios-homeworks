//
//  User.swift
//  Navigation
//
//  Created by 1234 on 12.06.2022.
//

import Foundation
import UIKit

final class User {
    let name: String
    let avatar: UIImage
    let status: String

    init(name: String, avatar: UIImage, status: String) {
        self.name = name
        self.avatar = avatar
        self.status = status
    }
}