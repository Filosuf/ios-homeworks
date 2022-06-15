//
//  LoginFactory .swift
//  Navigation
//
//  Created by 1234 on 14.06.2022.
//

import Foundation

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}
