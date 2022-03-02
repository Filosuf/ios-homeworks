//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by 1234 on 25.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let screenWidth = UIScreen.main.bounds.width

        if let firstView = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil)?.first as? ProfileView {
            firstView.frame = CGRect(x: 16, y: 100, width: screenWidth - 32, height: 400)
            view.addSubview(firstView)
        }
    }



}
