//
//  TestUserService.swift
//  Navigation
//
//  Created by 1234 on 14.06.2022.
//

import Foundation
import UIKit

final class TestUserService: UserService {

    let user = User(name: "login2@bk.ru", avatar: UIImage(named: "avatarDog.jpg")!, status: "Я счастлив(Debug)")
    
    func getUser(userName: String, completion: (Result<User, UserGetError>) -> Void) {
        if user.name == userName {
            completion(.success(user))
        } else {
            let debugUuser = User(name: userName, avatar: UIImage(systemName: "person.fill.questionmark")!, status: "Проверка работы Login сервиса")
            completion(.success(debugUuser))
//            completion(.failure(UserGetError.notFound))
        }
    }

}
