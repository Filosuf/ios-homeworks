//
//  ProfileHeaderViewController.swift
//  Navigation
//
//  Created by 1234 on 22.04.2022.
//

import UIKit

class ProfileHeaderViewController: UIViewController {


    let headerView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        view.backgroundColor = .systemGray4
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        headerView.profileImage.isUserInteractionEnabled = true
        headerView.profileImage.addGestureRecognizer(tapGesture)
    }

    @objc private func tapAction() {
        print("Сработало нажатие")

        addAvatarView()

        let positionAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        positionAnimation.fromValue = headerView.profileImage.center
        positionAnimation.toValue = view.center

        let sizeAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.bounds))
        sizeAnimation.fromValue =  [NSValue(cgSize: CGSize(width: self.headerView.profileImage.frame.size.width, height: self.headerView.profileImage.frame.size.height))]
        sizeAnimation.toValue = [NSValue(cgSize: CGSize(width: 300, height: 300))]

        let cornerRadiusAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius))
        cornerRadiusAnimation.fromValue = headerView.profileImage.layer.cornerRadius
        cornerRadiusAnimation.toValue = 0

        let borderWidthAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.borderWidth))
        borderWidthAnimation.fromValue = headerView.profileImage.layer.borderWidth
        borderWidthAnimation.toValue = 0

        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 3.0
//        groupAnimation.animations = [positionAnimation]
        groupAnimation.animations = [positionAnimation,sizeAnimation, cornerRadiusAnimation, borderWidthAnimation]
        groupAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        headerView.profileImage.layer.add(groupAnimation, forKey: nil)
//        headerView.profileImage.layer.position = view.center

//        headerView.profileImageWidthConstrain.constant = 100
//        headerView.profileImageHeightConstrain.constant = 100

        UIView.animate(withDuration: 3.0,
                       delay: 0.0,
                       options: [],
                       animations: {
            self.headerView.profileImageWidthConstrain.constant = 250
            self.headerView.profileImageHeightConstrain.constant = 250
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    private func layout() {
//        let headerView = ProfileHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false

        [headerView].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }

    private func addAvatarView() {
//        avatarView.translatesAutoresizingMaskIntoConstraints = false
        let avatar = headerView.profileImage
        let spaseInterval: CGFloat = 16



//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: nil)
        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(blurEffectView)
        UIView.animate(withDuration: 5) {
            blurEffectView.effect = UIBlurEffect(style: UIBlurEffect.Style.prominent)
        }

        [blurEffectView, avatar].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
//            avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            avatarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            avatarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            avatarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//
            avatar.topAnchor.constraint(equalTo: view.topAnchor, constant: spaseInterval),
            avatar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spaseInterval),
            headerView.profileImageHeightConstrain,
            headerView.profileImageWidthConstrain
        ])
    }
}
