//
//  FeedModel.swift
//  Navigation
//
//  Created by 1234 on 21.06.2022.
//

import Foundation

class FeedModel {

    let password = "Good work"
    var isValidWord = false {
        didSet {
            NotificationCenter.default.post(name: .updateIsValidWord, object: isValidWord)
        }
    }

//    private let notificationCenter: NotificationCenter
//
//    init(notificationCenter: NotificationCenter = .default) {
//        self.notificationCenter = notificationCenter
//    }


    func check(word: String) {
        if password == word {
            isValidWord = true
        } else {
            isValidWord = false
        }
    }
}
