//
//  MainCoordinatorTests.swift
//  NavigationTests
//
//  Created by Filosuf on 14.03.2023.
//

import XCTest
@testable import Navigation

class MainCoordinatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessShowProfileViewControllerWithLogin() throws {
        //given
        let coordinator = MainCoordinatorImp()
        let userEmail: String? = "login"
        var profileViewController: ProfileViewController?

        //when
        let tabBarController = coordinator.startApplication(userEmail: userEmail) as? MainTabBarController
        if let navVC = tabBarController?.viewControllers?[1] as? UINavigationController {
            let visibleVC = navVC.visibleViewController
            if let profileVC =  visibleVC as? ProfileViewController {
                profileViewController = profileVC
            }
        }
        //then
        XCTAssertNotNil(profileViewController)
    }

    func testFailedShowProfileViewControllerWithoutLogin() throws {
        //given
        let coordinator = MainCoordinatorImp()
        let userEmail: String? = nil
        var profileViewController: ProfileViewController?

        //when
        let tabBarController = coordinator.startApplication(userEmail: userEmail) as? MainTabBarController
        if let navVC = tabBarController?.viewControllers?[1] as? UINavigationController {
            let visibleVC = navVC.visibleViewController
            if let profileVC =  visibleVC as? ProfileViewController {
                profileViewController = profileVC
            }
        }
        //then
        XCTAssertNil(profileViewController)
    }

    func testSuccessShowLoginViewControllerWithoutLogin() throws {
        //given
        let coordinator = MainCoordinatorImp()
        let login: String? = nil
        var loginViewController: LogInViewController?

        //when
        let tabBarController = coordinator.startApplication(userEmail: login) as? MainTabBarController
        if let navVC = tabBarController?.viewControllers?[1] as? UINavigationController {
            let visibleVC = navVC.visibleViewController
            if let loginVC =  visibleVC as? LogInViewController {
                loginViewController = loginVC
            }
        }
        //then
        XCTAssertNotNil(loginViewController)
    }

    func testFailedShowLoginViewControllerWithLogin() throws {
        //given
        let coordinator = MainCoordinatorImp()
        let login: String? = "login"
        var loginViewController: LogInViewController?

        //when
        let tabBarController = coordinator.startApplication(userEmail: login) as? MainTabBarController
        if let navVC = tabBarController?.viewControllers?[1] as? UINavigationController {
            let visibleVC = navVC.visibleViewController
            if let loginVC =  visibleVC as? LogInViewController {
                loginViewController = loginVC
            }
        }
        //then
        XCTAssertNil(loginViewController)
    }
}
