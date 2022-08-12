//
//  CurrentUserService.swift
//  Navigation
//
//  Created by 1234 on 12.06.2022.
//

import Foundation
import UIKit

final class CurrentUserService: UserService {

    let user = User(name: "Добрый пёс", avatar: UIImage(named: "avatarDog.jpg")!, status: "Я счастлив")

    func getUser(userName: String, completion: (Result<User, UserGetError>) -> Void) {
        if user.name == userName {
            completion(.success(user))
        } else {
            completion(.failure(UserGetError.notFound))
        }
    }


}
