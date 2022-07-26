//
//  CellImage.swift
//  CollectionView+GrandCentralDispath(GCD)
//
//  Created by Artem Mushtakov on 24.07.2022.
//

import UIKit

final class CellImage: UICollectionViewCell {

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties

    private var activityIndicator = UIActivityIndicatorView()

    private lazy var titleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    } ()

    private var imageUrl: URL? {
        didSet {
            titleImage.image = nil
            updateImage()
        }
    }

    // MARK: Setup view

    private func setupView() {
        setupHierarchy()
        setupConstraints()
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 20
        self.contentView.backgroundColor = .blue.withAlphaComponent(0.2)
    }

    private func setupHierarchy() {
        self.contentView.addSubview(titleImage)
        titleImage.addSubview(activityIndicator)
    }

    private func setupConstraints() {

        titleImage.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            titleImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            titleImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            titleImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: titleImage.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: titleImage.centerYAnchor)
        ])
    }

    // MARK: - Setup func load data

    private func updateImage() {
        if let url = imageUrl {
            if url == self.imageUrl {
                self.titleImage.downloaded(from: url,
                                           imageURL: self.imageUrl,
                                           activityIndicator: activityIndicator)
            }
        }
    }

    func loadImageUrl(url: URL?) {
        if let url = url {
            self.imageUrl = url
        }
    }
}
