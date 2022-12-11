//
//  InfoView.swift
//  Navigation
//
//  Created by 1234 on 19.08.2022.
//

import UIKit
import SnapKit

protocol InfoViewDelegate: AnyObject {
    func didTapFirstTaskButton()
    func didTapSecondTaskButton()
    func didTapThirdTaskButton()
}

class InfoView: UIView {

    weak var delegate: InfoViewDelegate?

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    }()

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false

        return contentView
    }()

    private let firstTaskButton = CustomButton(title: "Первая задача", backgroundColor: .systemGreen)
    private let firstTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "Поле для вывода результата первой задачи"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    private let secondTaskButton = CustomButton(title: "Вторая задача", backgroundColor: .systemYellow)
    private let secondTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "Поле для вывода результата второй задачи"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    private let thirdTaskButton = CustomButton(title: "Третья задача", backgroundColor: .systemRed)
    private let thirdTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "Поле для вывода результата третьей задачи"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.dataSource = self
//        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        return tableView
    }()

    // MARK: - Initialiser
    init(delegate: InfoViewDelegate?) {
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
        firstTaskButton.tapAction = { [weak self] in
            self?.delegate?.didTapFirstTaskButton()
        }
        secondTaskButton.tapAction = { [weak self] in
            self?.delegate?.didTapSecondTaskButton()
        }
        thirdTaskButton.tapAction = { [weak self] in
            self?.delegate?.didTapThirdTaskButton()
        }
    }

    func setTableView(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }

    func reloadData() {
        tableView.reloadData()
    }

    func setTextFirstTaskLabel(_ text: String) {
        firstTaskLabel.text = text
    }
    func setTextSecondTaskLabel(_ text: String) {
        secondTaskLabel.text = text
    }
    func setTextThirdTaskLabel(_ text: String) {
        thirdTaskLabel.text = text
    }

    private func layout() {
        [firstTaskLabel,
         firstTaskButton,
         secondTaskLabel,
         secondTaskButton,
         thirdTaskLabel,
         thirdTaskButton,
         tableView
        ].forEach { contentView.addSubview($0)}

        scrollView.addSubview(contentView)
        addSubview(scrollView)
        
        firstTaskLabel.snp.makeConstraints{
            $0.top.leading.equalTo(contentView).offset(30)
            $0.trailing.equalTo(contentView).offset(-30)
        }
        firstTaskButton.snp.makeConstraints{
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(firstTaskLabel.snp.bottom).offset(30)
        }

        secondTaskLabel.snp.makeConstraints{
            $0.top.equalTo(firstTaskButton.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(firstTaskLabel)
        }
        secondTaskButton.snp.makeConstraints{
            $0.centerX.equalTo(firstTaskButton.snp.centerX)
            $0.top.equalTo(secondTaskLabel.snp.bottom).offset(30)
        }

        thirdTaskLabel.snp.makeConstraints{
            $0.top.equalTo(secondTaskButton.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(firstTaskLabel)
        }
        thirdTaskButton.snp.makeConstraints{
            $0.centerX.equalTo(firstTaskButton.snp.centerX)
            $0.top.equalTo(thirdTaskLabel.snp.bottom).offset(30)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(thirdTaskButton.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(firstTaskLabel)
            $0.height.equalTo(250)
            $0.bottom.equalTo(contentView.snp.bottom)
        }

        contentView.snp.makeConstraints{
            $0.edges.width.equalTo(scrollView)
        }

        scrollView.snp.makeConstraints{
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
