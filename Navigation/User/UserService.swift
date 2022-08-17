//
//  UserService.swift
//  Navigation
//
//  Created by 1234 on 12.06.2022.
//

import Foundation

enum UserGetError: Error {
    case notFound
    case unowned
}

protocol UserService {
    func getUser(userName: String, completion: (Result<User,UserGetError>) -> Void)
}
