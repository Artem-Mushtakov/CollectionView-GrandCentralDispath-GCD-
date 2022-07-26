//
//  UIImage+Extension.swift
//  CollectionView+GrandCentralDispath(GCD)
//
//  Created by Artem Mushtakov on 28.07.2022.
//

import UIKit

extension UIImage {

    func applySepiaFilter() -> UIImage {
        guard let pngData = self.pngData() else { return UIImage() }
        let inputImage = CIImage(data: pngData)

        let context = CIContext(options: nil)

        guard let filter = CIFilter(name:"CISepiaTone") else { return UIImage() }
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(0.8, forKey: "inputIntensity")
        guard let outputImage = filter.outputImage else { return UIImage() }

        guard let outImage = context.createCGImage(outputImage, from: outputImage.extent) else { return UIImage() }
        let returnImage = UIImage(cgImage: outImage)

        return returnImage
    }
}
