//
//  Checker.swift
//  Navigation
//
//  Created by 1234 on 14.06.2022.
//

import Foundation
import FirebaseAuth
import AVFoundation
import RealmSwift

final class DatabaseModel: Object {
    @Persisted var email: String = ""
    @Persisted var password: String = ""
}

protocol CheckerServiceProtocol {
    func checkCredentials(login: String, password: String, success: @escaping (Bool) -> Void)
    func signUp(login: String, password: String, response: @escaping (Error?) -> Void)
}


class Checker: CheckerServiceProtocol {


    static let shared = Checker()

    private let login = "login"
    private let password = "qwerty"

    private init() {}

    func authorization(login: String, password: String) -> Bool {
        return self.login.hash == login.hash && self.password.hash == password.hash
    }

    func checkCredentials(login: String, password: String, success: @escaping (Bool) -> Void) {
        guard let realm = try? Realm() else { return }

        do {
            try realm.write {
                let userSession = DatabaseModel()
                userSession.email = login
                userSession.password = password
                realm.add(userSession)
                success(true)
            }
        } catch {
            print(error)
            success(false)
        }
    }

    func signUp(login: String, password: String, response: @escaping (Error?) -> Void) {
        guard let realm = try? Realm() else { return }

        do {
            try realm.write {
                let userSession = DatabaseModel()
                userSession.email = login
                userSession.password = password
                realm.add(userSession)
            }
        } catch {
            print(error)
            response(error)
        }
    }

    func writeDebug() {
        guard let realm = try? Realm() else { return }

        do {
            try realm.write {
                let userSession = DatabaseModel()
                userSession.email = "login6"
                userSession.password = "12345"
                realm.add(userSession)
            }
        } catch {
            print(error)
        }
    }

    func getLogin() -> String? {
        guard let realm = try? Realm() else { return nil }
        let email = realm.objects(DatabaseModel.self).first?.email
        print("Get email = \(email)")
        return email
    }

    func deleteLogin() {
        guard let realm = try? Realm() else { return }

        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }

    // MARK: Firebase
//    func checkCredentials(login: String, password: String, success: @escaping (Bool) -> Void) {
//        FirebaseAuth.Auth.auth().signIn(withEmail: login, password: password) { result, error in
//            success(error == nil)
//        }
//    }
//
//    func signUp(login: String, password: String, response: @escaping (Error?) -> Void) {
//        FirebaseAuth.Auth.auth().createUser(withEmail: login, password: password) { result, error in
//            response(error)
//        }
//    }
}
