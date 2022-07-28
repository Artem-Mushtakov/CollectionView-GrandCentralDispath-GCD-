//
//  HeaderCellFemale.swift.swift
//  CollectionView+GrandCentralDispath(GCD)
//
//  Created by Artem Mushtakov on 24.07.2022.
//

import UIKit
import CoreImage.CIFilterBuiltins

class HeaderCellFemale: UICollectionReusableView {

    // MARK: - Properties

    var label: UILabel = {
        let label = UILabel()
        label.textColor  = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
           super.init(frame: frame)
           configure()
       }

       required init?(coder: NSCoder) {
           fatalError("Not implemented")
       }

    // MARK: - Setup Layout

    private func configure() {
        addSubview(label)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        ])
    }
}
