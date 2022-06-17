//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by 1234 on 14.06.2022.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {

    func check(login: String, password: String) -> Bool
}

