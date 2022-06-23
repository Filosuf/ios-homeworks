//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by 1234 on 12.03.2022.
//

import UIKit
import SnapKit

final class ProfileHeaderView: UIView {

    //MARK: - Properties
    
    private var statusText = ""
    private var defaultAvatarCenter: CGPoint = CGPoint(x: 0, y: 0)

    private let profileImageRadius: CGFloat = 100

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
        button.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.layer.opacity = 0
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(self.hideAvatar), for: .touchUpInside)
        return button
    }()

    lazy var profileImage: UIImageView = {

        let image = UIImageView()
//        image.image = UIImage(named: "avatarDog.jpg")
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
        label.text = "User name"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let statusLabel: UILabel = {

        let label = UILabel()
        label.text = "Status"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let showStatusButton: CustomButton = {

        let button = CustomButton(title: "Set status", titleColor: .white, backgroundColor: .systemBlue)
        button.layer.cornerRadius = 4
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)

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

    //MARK: - LifeCicle

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layout()
        taps()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Metods

    @objc func showAvatar() {
        guard profileImage.image != nil else {return}

        UIImageView.animate(withDuration: 0.5,
                            animations: {
            self.defaultAvatarCenter = self.profileImage.center
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

    func taps() {
        showStatusButton.tapAction =  { [weak self] in
            self?.statusLabel.text = self?.statusText
            self?.endEditing(true)
        }

    }

    @objc func statusTextChanged(_ textField: UITextField) {
        if let setStatus = textField.text {
            statusText = setStatus
        }
    }

    func setupView(user: User?) {
        guard let user = user else {print("Error: User nil in ProfileHeaderView." + #function); return}
        nameLabel.text = user.name
        profileImage.image = user.avatar
        statusLabel.text = user.status
    }

    private func layout() {
        let spaseInterval: CGFloat = 16

        [nameLabel, statusLabel, showStatusButton, statusSetTextField, blurEffectView, profileImage, xmarkButton].forEach { self.addSubview($0) }

        profileImage.snp.makeConstraints{
            $0.top.equalToSuperview().offset(spaseInterval)
            $0.leading.equalToSuperview().offset(spaseInterval)
            $0.height.equalTo(profileImageRadius)
            $0.width.equalTo(profileImageRadius)
        }

        nameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(27)
            $0.leading.equalToSuperview().offset(profileImageRadius + spaseInterval * 2)
            $0.trailing.equalToSuperview().offset(-spaseInterval)
            $0.height.equalTo(18)
        }

        showStatusButton.snp.makeConstraints{
            $0.top.equalTo(statusSetTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(spaseInterval)
            $0.trailing.equalToSuperview().offset(-spaseInterval)
            $0.height.equalTo(50)
        }

        statusLabel.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(35)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-spaseInterval)
            $0.height.equalTo(14)
        }

        statusSetTextField.snp.makeConstraints{
            $0.top.equalTo(statusLabel.snp.bottom).offset(10)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-spaseInterval)
            $0.height.equalTo(40)
        }

        xmarkButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(spaseInterval)
            $0.trailing.equalToSuperview().offset(-spaseInterval)
        }
    }

}

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
