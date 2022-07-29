//
//  UIImageView+Extension.swift
//  CollectionView+GrandCentralDispath(GCD)
//
//  Created by Artem Mushtakov on 28.07.2022.
//

import UIKit

extension UIImageView {

    func downloaded(from url: URL?, imageURL: URL?, activityIndicator: UIActivityIndicatorView) {
        guard let url = url else { return }

        activityIndicator.startAnimating()

        DispatchQueue.global(qos: .userInitiated).async {
            
            let contentsOfURL = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if url == imageURL {
                    if let imageData = contentsOfURL {
                        self.image = UIImage(data: imageData)
                    } else {
                        print("Error download image")
                    }
                    activityIndicator.stopAnimating()
                }
            }
        }
    }
}
