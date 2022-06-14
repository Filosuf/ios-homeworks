//
//  UserService.swift
//  Navigation
//
//  Created by 1234 on 12.06.2022.
//

import Foundation

protocol UserService {
    func getUser(userName: String) -> User?
}
