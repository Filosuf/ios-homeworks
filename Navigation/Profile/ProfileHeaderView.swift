//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by 1234 on 12.03.2022.
//

import UIKit

final class ProfileHeaderView: UIView {

private var statusText = ""

    private let profileImageRadius: CGFloat = 100
    lazy var profileImageHeightConstrain = profileImage.heightAnchor.constraint(equalToConstant: profileImageRadius)
    lazy var profileImageWidthConstrain = profileImage.widthAnchor.constraint(equalToConstant: profileImageRadius)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        constraints()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    let profileImage: UIImageView = {

        let image = UIImageView()
        image.image = UIImage(named: "avatarDog.jpg")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 100 / 2
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false

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

        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: spaseInterval),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaseInterval),
            profileImageHeightConstrain,
            profileImageWidthConstrain
//            profileImage.heightAnchor.constraint(equalToConstant: 100),
//            profileImage.widthAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: profileImageRadius + spaseInterval * 2),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaseInterval),
            nameLabel.heightAnchor.constraint(equalToConstant: 18)
        ])

        NSLayoutConstraint.activate([
            showStatusButton.topAnchor.constraint(equalTo: statusSetTextField.bottomAnchor, constant: 10),
            showStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaseInterval),
            showStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaseInterval),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 35),
            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaseInterval),
            statusLabel.heightAnchor.constraint(equalToConstant: 14)
        ])

        NSLayoutConstraint.activate([
            statusSetTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            statusSetTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusSetTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaseInterval),
            statusSetTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupViews() {
        self.addSubview(nameLabel)
        self.addSubview(statusLabel)
        self.addSubview(showStatusButton)
        self.addSubview(statusSetTextField)
        self.addSubview(profileImage)    }

    @objc private func tapAction() {
        print("Сработало нажатие во view")
    }

    
}

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
