//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by 1234 on 12.03.2022.
//

import UIKit

final class ProfileHeaderView: UIView {

    private var statusText = ""
    private var defaultAvatarCenter: CGPoint = CGPoint(x: 0, y: 0)

        private let profileImageRadius: CGFloat = 100
        lazy var profileImageHeightConstrain = profileImage.heightAnchor.constraint(equalToConstant: profileImageRadius)
        lazy var profileImageWidthConstrain = profileImage.widthAnchor.constraint(equalToConstant: profileImageRadius)

        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
            constraints()
        }

        required init?(coder aDecoder: NSCoder)
        {
            fatalError("init(coder:) has not been implemented")
        }

        private lazy var blurEffectView: UIVisualEffectView = {
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    //        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.prominent)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            blurEffectView.layer.opacity = 0
            blurEffectView.isUserInteractionEnabled = false
            return blurEffectView
        }()

        private lazy var xmarkButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "xmark"), for: .normal)
//            button.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
            button.layer.opacity = 0
            button.backgroundColor = .clear
            button.addTarget(self, action: #selector(self.hideAvatar), for: .touchUpInside)
            return button
        }()

        lazy var profileImage: UIImageView = {

            let image = UIImageView()
            image.image = UIImage(named: "avatarDog.jpg")
            image.contentMode = .scaleAspectFill
            image.layer.cornerRadius = 100 / 2
            image.layer.borderWidth = 3
            image.layer.borderColor = UIColor.white.cgColor
            image.clipsToBounds = true
            image.translatesAutoresizingMaskIntoConstraints = false
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.showAvatar))
            recognizer.numberOfTapsRequired = 1
            image.addGestureRecognizer(recognizer)
            image.isUserInteractionEnabled = true

            return image
        }()

        private let nameLabel: UILabel = {

            let label = UILabel()
            label.text = "Добрый пёс"
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false

            return label
        }()

        private let statusLabel: UILabel = {

            let label = UILabel()
            label.text = "Я счастлив"
            label.textColor = .gray
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            label.translatesAutoresizingMaskIntoConstraints = false

            return label
        }()

        private let showStatusButton: UIButton = {

            let button = UIButton()
            button.setTitle("Set status", for: .normal)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 4
            button.layer.shadowRadius = 4
            button.layer.shadowOpacity = 0.7
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 4, height: 4)
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false

            return button
        }()

        private lazy var statusSetTextField: UITextField = {

            let textField = UITextField()
            textField.placeholder = "Введите новый статус"
            textField.clearButtonMode = .whileEditing
            textField.textColor = .black
            textField.backgroundColor = .white
            textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            textField.layer.cornerRadius = 12
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.black.cgColor
            textField.clipsToBounds = true
            textField.delegate = self
            textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
            textField.translatesAutoresizingMaskIntoConstraints = false

            let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
            textField.leftViewMode = UITextField.ViewMode.always
            textField.leftView = spacerView

            return textField
        }()

        @objc func showAvatar() {
            UIImageView.animate(withDuration: 0.5,
                                animations: {
                self.defaultAvatarCenter = self.profileImage.center
    //            self.profileImage.center = CGPoint(x: UIScreen.main.bounds.midX, y: (UIScreen.main.bounds.midY + ProfileViewController.tableView.contentOffset.y))
                self.profileImage.center = CGPoint(x: UIScreen.main.bounds.midX, y: (UIScreen.main.bounds.midY - 40))
                self.profileImage.transform = CGAffineTransform(scaleX: self.bounds.width / self.profileImage.frame.width, y: self.bounds.width / self.profileImage.frame.width)
                self.profileImage.layer.cornerRadius = 0
                self.profileImage.layer.borderWidth = 0
                self.profileImage.isUserInteractionEnabled = false
                self.showStatusButton.isUserInteractionEnabled = false
                self.statusSetTextField.isUserInteractionEnabled = false
                self.blurEffectView.layer.opacity = 1
                ProfileViewController.tableView.isScrollEnabled = false
                ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = false
                ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 1))?.isUserInteractionEnabled = false

            },
                                completion: { _ in
                UIImageView.animate(withDuration: 0.3) {
                    self.xmarkButton.layer.opacity = 1
                }
            })
        }

        @objc func hideAvatar() {
            UIImageView.animate(withDuration: 0.3,
                                animations: {
                self.xmarkButton.layer.opacity = 0
            },
                                completion: { _ in
                UIImageView.animate(withDuration: 0.5) {
                    self.profileImage.center = self.defaultAvatarCenter
                    self.profileImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
                    self.profileImage.layer.borderWidth = 3
                    self.profileImage.isUserInteractionEnabled = true
                    self.blurEffectView.layer.opacity = 0
                    self.showStatusButton.isUserInteractionEnabled = true
                    self.statusSetTextField.isUserInteractionEnabled = true
                    ProfileViewController.tableView.isScrollEnabled = true
                    ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = true
                    ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 1))?.isUserInteractionEnabled = true
                }
            })
        }

        @objc func buttonPressed() {
            statusLabel.text = statusText
            self.endEditing(true)
        }

        @objc func statusTextChanged(_ textField: UITextField) {
            if let setStatus = textField.text {
                statusText = setStatus
            }
        }

        private func constraints() {
            let spaseInterval: CGFloat = 16

            [nameLabel, statusLabel, showStatusButton, statusSetTextField, blurEffectView, profileImage, xmarkButton].forEach { self.addSubview($0) }

            NSLayoutConstraint.activate([
                profileImage.topAnchor.constraint(equalTo: topAnchor, constant: spaseInterval),
                profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaseInterval),
                profileImageHeightConstrain,
                profileImageWidthConstrain,
    //            profileImage.heightAnchor.constraint(equalToConstant: 100),
    //            profileImage.widthAnchor.constraint(equalToConstant: 100),

                nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
                nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: profileImageRadius + spaseInterval * 2),
                nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaseInterval),
                nameLabel.heightAnchor.constraint(equalToConstant: 18),

                showStatusButton.topAnchor.constraint(equalTo: statusSetTextField.bottomAnchor, constant: 10),
                showStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaseInterval),
                showStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaseInterval),
                showStatusButton.heightAnchor.constraint(equalToConstant: 50),

                statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 35),
                statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaseInterval),
                statusLabel.heightAnchor.constraint(equalToConstant: 14),

                statusSetTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
                statusSetTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                statusSetTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaseInterval),
                statusSetTextField.heightAnchor.constraint(equalToConstant: 40),

                xmarkButton.topAnchor.constraint(equalTo: topAnchor, constant: spaseInterval),
                xmarkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaseInterval)
            ])
        }

    }

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
