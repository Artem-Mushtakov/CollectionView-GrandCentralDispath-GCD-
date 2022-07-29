//
//  CellText.swift
//  CollectionView+GrandCentralDispath(GCD)
//
//  Created by Artem Mushtakov on 24.07.2022.
//

import UIKit

final class CellText: UICollectionViewCell {

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    } ()

    // MARK: Setup view

    private func setupView() {
        setupHierarchy()
        setupConstraints()

        self.contentView.layer.cornerRadius = 20
        self.contentView.backgroundColor = .cyan.withAlphaComponent(0.2)
    }

    private func setupHierarchy() {
        self.contentView.addSubview(titleLabel)
    }

    private func setupConstraints() {

        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: self.contentView.frame.width - 30),
            titleLabel.heightAnchor.constraint(equalToConstant: self.contentView.frame.height - 30)
        ])
    }

    // MARK: - Func load data

    func loadData(text: String) {
        titleLabel.text = text
    }
}
