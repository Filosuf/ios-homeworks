//
//  CustomTextField.swift
//  Navigation
//
//  Created by 1234 on 21.06.2022.
//

import Foundation
import UIKit

class CustomTextField: UITextField {

    init(placeholder: String = "", textColor: UIColor = .black, backgroundColor: UIColor = .white) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setTextField(placeholder: placeholder, textColor: textColor, backgroundColor: backgroundColor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setTextField(placeholder: String, textColor: UIColor,  backgroundColor: UIColor) {
        self.placeholder = placeholder
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: 20)
        self.backgroundColor = backgroundColor
        self.autocapitalizationType = .none
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftViewMode = UITextField.ViewMode.always
        self.delegate = self
        self.leftView = UIView(frame:CGRect(x:0, y:0, width:10, height:self.frame.height))
        self.rightView = UIView(frame:CGRect(x:0, y:0, width:10, height:self.frame.height))
        self.rightViewMode = .always
        translatesAutoresizingMaskIntoConstraints = false
    }

}

extension CustomTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}
