//
//  TestUserService.swift
//  Navigation
//
//  Created by 1234 on 14.06.2022.
//

import Foundation
import UIKit

class TestUserService: UserService {

    let user = User(name: "login", avatar: UIImage(named: "avatarDog.jpg")!, status: "Я счастлив(Debug)")
    
    func getUser(userName: String) -> User? {
        if user.name == userName {
            return user
        }
        return nil
    }

}
