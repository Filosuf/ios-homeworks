//
//  FeedView.swift
//  Navigation
//
//  Created by 1234 on 20.06.2022.
//

import UIKit
import SnapKit

protocol FeedViewDelegate: AnyObject {
    func didTapPostButton()
    func check(word: String)
}

final class FeedView: UIView {

    weak var delegate: FeedViewDelegate?

    private let postButtonFirst = CustomButton(title: "Post #1", backgroundColor: .systemGray)
    private let postButtonSecond = CustomButton(title: "Post #2", backgroundColor: .systemGray)

    private let notificationButton = CustomButton(title: "Notification", backgroundColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))

    private let textField = CustomTextField(placeholder: "Good work", backgroundColor: .systemGray5)

    private let resultLabel: UILabel = {

        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let buttonVerticalStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10

        return stackView
    }()

    init(delegate: FeedViewDelegate?) {
        super.init(frame: CGRect.zero)
        self.delegate = delegate
        backgroundColor = .white
        layout()
        taps()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Metods

    private func taps() {
        postButtonFirst.tapAction = { [weak self] in
            self?.delegate?.didTapPostButton()
        }
        postButtonSecond.tapAction = { [weak self] in
            self?.delegate?.didTapPostButton()
        }
        notificationButton.tapAction = { [weak self] in
            self?.delegate?.check(word: self?.textField.text ?? "")
        }
    }

    func setResultLabel(result: Bool) {
        if result {
            resultLabel.text = "Верно"
            resultLabel.textColor = .systemGreen
        } else {
            resultLabel.text = "Не верно"
            resultLabel.textColor = .systemRed
        }
    }

    private func layout() {
        [postButtonFirst,
         postButtonSecond
        ].forEach { buttonVerticalStackView.addArrangedSubview($0)}

        [buttonVerticalStackView,
         textField,
         notificationButton,
         resultLabel
        ].forEach { addSubview($0)}

        buttonVerticalStackView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(52 * 2 + 10)
        }

        textField.snp.makeConstraints{
            $0.leading.trailing.equalTo(buttonVerticalStackView)
            $0.top.equalTo(buttonVerticalStackView.snp.bottom).offset(40)
        }

        notificationButton.snp.makeConstraints{
            $0.top.equalTo(textField.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(textField)
        }

        resultLabel.snp.makeConstraints{
            $0.top.equalTo(notificationButton.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(textField)
        }

    }
}
