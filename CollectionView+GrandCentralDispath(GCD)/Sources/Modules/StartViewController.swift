//
//  StartViewController.swift
//  CollectionView+GrandCentralDispath(GCD)
//
//  Created by Artem Mushtakov on 24.07.2022.
//

import UIKit

protocol StartViewOutputProtocol: AnyObject {
    func succes()
}

final class StartViewController: UIViewController {

    // MARK: - Properties

    var presenter: StartPresenter?

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(CellImage.self, forCellWithReuseIdentifier: "CellImage")
        collectionView.register(CellText.self, forCellWithReuseIdentifier: "CellText")
        return collectionView
    } ()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        activityIndicator.color = .red
        activityIndicator.startAnimating()
        return activityIndicator
    } ()

    // MARK: - Live cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: Setup View

    private func setupView() {
        view.addSubview(collectionView)
        collectionView.addSubview(activityIndicator)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

// MARK: - UICollectionViewDelegate

extension StartViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = presenter?.sectionModel else { return 0 }

        switch section {
        case 0:
            return model["FemaleSection"]?.count ?? 0
        case 1:
            return model["MaleSection"]?.count ?? 0
        case 2:
            return model["UnknownSection"]?.count ?? 0
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = presenter?.sectionModel else { return UICollectionViewCell() }
        switch indexPath.section {
        case 0:
            return setupCellText(collectionView: collectionView, model: model["FemaleSection"]?[indexPath.row], indexPath: indexPath)
        case 1:
            return setupCellImage(collectionView: collectionView, model: model["MaleSection"]?[indexPath.row], indexPath: indexPath)
        case 2:
            return setupCellText(collectionView: collectionView, model: model["UnknownSection"]?[indexPath.row], indexPath: indexPath)
        default:
            return setupCellText(collectionView: collectionView, model: model["MaleSection"]?[indexPath.row], indexPath: indexPath)
        }
    }

    private func setupCellImage(collectionView: UICollectionView, model: Result?, indexPath: IndexPath) -> UICollectionViewCell {
        let cellImage = collectionView.dequeueReusableCell(withReuseIdentifier: "CellImage", for: indexPath) as? CellImage

        guard let model = model, let cellImage = cellImage,
              let urlString = (model.image),
              let url = URL(string: urlString) else { return UICollectionViewCell() }

        cellImage.titleImage.downloaded(from: url)

        return cellImage
    }

    private func setupCellText(collectionView: UICollectionView, model: Result?, indexPath: IndexPath) -> UICollectionViewCell {
        let celltext = collectionView.dequeueReusableCell(withReuseIdentifier: "CellText", for: indexPath) as? CellText

        guard let celltext = celltext, let name = model?.name else { return UICollectionViewCell() }

        celltext.titleLabel.text = name
        return celltext
    }
}

// MARK: - StartViewOutputProtocol

extension StartViewController: StartViewOutputProtocol {

    func succes() {
        DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
                self?.activityIndicator.stopAnimating()
        }
    }
}

// MARK: Setup composition layout

extension StartViewController {

    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {

           return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in

               switch sectionNumber {
               case 0: return self.createCompositionalLayoutTopGroup()
               case 1: return self.createCompositionalLayoutCenterGroup()
               default:
                   return self.createCompositionalLayoutTopGroup()
               }
           }
       }

    private func createCompositionalLayoutTopGroup() -> NSCollectionLayoutSection {

        let inset: CGFloat = 10

        let topItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let topItem = NSCollectionLayoutItem(layoutSize: topItemSize)

        topItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        let topGroup = NSCollectionLayoutGroup.horizontal(layoutSize: topItemSize, subitem: topItem, count: 2)

        let bottomGroup = NSCollectionLayoutGroup.horizontal(layoutSize: topItemSize, subitem: topItem, count: 2)

        let fullGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: fullGroupSize, subitems: [topGroup, bottomGroup])

        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }

    private func createCompositionalLayoutCenterGroup() -> NSCollectionLayoutSection {

        let inset: CGFloat = 10

        let topItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
        let topItem = NSCollectionLayoutItem(layoutSize: topItemSize)
        topItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        let topGroup = NSCollectionLayoutGroup.vertical(layoutSize: topItemSize, subitem: topItem, count: 1)

        let bottomGroup = NSCollectionLayoutGroup.vertical(layoutSize: topItemSize, subitem: topItem, count: 1)

        let fullGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.8))
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: fullGroupSize, subitems: [topGroup, bottomGroup])

        let section = NSCollectionLayoutSection(group: nestedGroup)

        return section
    }
}
