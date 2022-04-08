//
//  UIView+Extension.swift
//  Navigation
//
//  Created by 1234 on 02.04.2022.
//

import UIKit

extension UIView {
    static let identifier = String(describing: self)

    func toAutoLayout() {
            translatesAutoresizingMaskIntoConstraints = false
        }
}
