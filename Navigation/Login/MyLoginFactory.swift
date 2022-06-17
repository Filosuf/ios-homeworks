//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by 1234 on 15.06.2022.
//

import Foundation

class MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {

        return LoginInspector()
    }

}
