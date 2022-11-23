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

protocol CheckerServiceProtocol {
    func checkCredentials(login: String, password: String, success: @escaping (Bool) -> Void)
    func signUp(login: String, password: String, response: @escaping (Error?) -> Void)
}


class Checker: CheckerServiceProtocol {


    static let shared = Checker()
//    private let realmCoordinator = RealmCoordinator()
//    private let login = "login"
//    private let password = "qwerty"

    private init() {}

//    func authorization(login: String, password: String) -> Bool {
//        return self.login.hash == login.hash && self.password.hash == password.hash
//    }

    func checkCredentials(login: String, password: String, success: @escaping (Bool) -> Void) {
        do {
            let realm = try Realm()

            let objects = realm.objects(DatabaseModel.self)
            let databaseLogin = objects[0].login
            let databasePassword = objects[0].password
            print("Database read login = \(databaseLogin), password = \(databasePassword)")
            if login == databaseLogin, password == databasePassword {
                success(true)
            } else {
                success(true)
            }
        } catch {
            success(false)
        }
    }

    func signUp(login: String, password: String, response: @escaping (Error?) -> Void) {
        do {
            let realm = try Realm()

            try self.safeWrite(in: realm) {

                let model = DatabaseModel(login: login, password: password)
                let object = realm.create(DatabaseModel.self, value: ["user": model], update: .all)
                response(nil)
                print("RealmDatabase: login/password save")
            }
        } catch {
            response(DatabaseError.error(desription: "Fail to create object in storage"))
        }
    }


    func writeDebug() {
        let model = DatabaseModel(login: "log", password: "123")
        create(DatabaseModel.self, keyedValues: [["user": model]]) { result in
            print(result)
        }
    }
    private func create<T>(_ model: T.Type, keyedValues: [[String: Any]], completion: @escaping (Result<[T], DatabaseError>) -> Void) where T : Storable {
        do {
            let realm = try Realm()

            try self.safeWrite(in: realm) {
                guard let model = model as? Object.Type else {
                    self.mainQueue.async { completion(.failure(.wrongModel)) }
                    return
                }

                var objects: [Object] = []
                keyedValues.forEach {
                    let object = realm.create(model, value: $0, update: .all)
                    objects.append(object)
                }

                guard let result = objects as? [T] else {
                    completion(.failure(.wrongModel))
                    return
                }

                completion(.success(result))
            }
        } catch {
            completion(.failure(.error(desription: "Fail to create object in storage")))
        }
    }

    func getLogin() -> String? {
        do {
            let realm = try Realm()

            let objects = realm.objects(DatabaseModel.self)
            if !objects.isEmpty {
                let databaseLogin = objects[0].login
                print("Database read login = \(databaseLogin)")
                return databaseLogin
            } else {
                print("Database empty")
                return nil
            }
        } catch {
            return nil
        }
    }

    private let backgroundQueue = DispatchQueue(label: "RealmContext", qos: .background)
    private let mainQueue = DispatchQueue.main

    private func safeWrite(in realm: Realm, _ block: (() throws -> Void)) throws {
        realm.isInWriteTransaction
        ? try block()
        : try realm.write(block)
    }
    // MARK: - Firebase
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
