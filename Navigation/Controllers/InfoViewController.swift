//
//  InfoViewController.swift
//  Navigation
//
//  Created by 1234 on 06.03.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private let alertButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemOrange
        title = "Info"
        
        alertButton.setTitle("Alert", for: .normal)
        view.addSubview(alertButton)
        alertButton.backgroundColor = .white
        alertButton.setTitleColor(.black, for: .normal)
        alertButton.frame = CGRect(x: 100, y: 100, width: 200, height: 52)
        alertButton.addTarget(self, action: #selector(didTapAlertButton), for: .touchUpInside)
    }

    @objc private func didTapAlertButton() {
        let alert = UIAlertController(title: "Внимание", message: "Важная информация", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in print("Alert: Ok")})
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: { _ in print("Alert: Cancel")})
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}
