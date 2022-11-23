//
//  DatabaseModel.swift
//  Navigation
//
//  Created by Filosuf on 23.11.2022.
//

import Foundation
import RealmSwift

final class DatabaseModel: Object {
    @objc dynamic var login: String = ""
    @objc dynamic var password: String = ""

    override static func primaryKey() -> String? {
        return "login"
    }

    convenience init(login: String, password: String) {
        self.init()
        self.login = login
        self.password = password
    }
}
