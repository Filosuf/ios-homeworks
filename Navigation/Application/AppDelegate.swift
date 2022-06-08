
//
//  AppDelegate.swift
//  Navigation
//
//  Created by 1234 on 24.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(#function + "\nAppDelegate: Успешный запуск приложения")
        let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = MainTabBarController()
            window.makeKeyAndVisible()

            self.window = window
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print(#function + "\nAppDelegate: Переключение на другое приложение или нажатие копки «Home»")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print(#function + "\nAppDelegate: Приложение перешло в состояние Active»")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function + "\nAppDelegate: Переход в состояние Background»")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print(#function + "\nAppDelegate: Переход из Background в состояние Foreground»")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print(#function + "\nAppDelegate: Пользователь закрывает приложение»")
    }

}
