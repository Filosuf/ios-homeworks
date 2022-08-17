//
//  VoiceRecView.swift
//  Navigation
//
//  Created by 1234 on 15.08.2022.
//

import UIKit

protocol VoiceRecViewDelegate: AnyObject {
    func didTapPlayButton()
    func didTapRecButton()
}

final class VoiceRecView: UIView {

    // MARK: - Properties
    weak var delegate: VoiceRecViewDelegate?

    private let playButton = CustomButton(title: "Play", backgroundColor: .systemGray)
    private let recButton = CustomButton(title: "Record", backgroundColor: .systemGray)

    private let trackNameLabel: UILabel = {

        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let buttonHorizontalStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20

        return stackView
    }()

    // MARK: - Initialiser
    init(delegate: VoiceRecViewDelegate?) {
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

    // MARK: - Metods
    private func taps() {
        playButton.tapAction = { [weak self] in
            self?.delegate?.didTapPlayButton()
        }
       recButton.tapAction = { [weak self] in
            self?.delegate?.didTapRecButton()
        }
    }

    func setTitleRecButton(_ title: String) {
        recButton.setTitle(title, for: .normal)
    }

    func setTitlePlayButton(_ title: String) {
        playButton.setTitle(title, for: .normal)
    }

    private func layout() {
        [playButton,
         recButton
        ].forEach { buttonHorizontalStackView.addArrangedSubview($0)}

        [buttonHorizontalStackView,
         trackNameLabel
        ].forEach { addSubview($0)}

        trackNameLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
        }

        buttonHorizontalStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(trackNameLabel.snp.bottom).offset(30)
            $0.width.equalTo(400)
            $0.height.equalTo(60)
        }

    }
}
