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

        if let firstView = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil) as? ProfileView {
            firstView.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        }
    }



}
