//
//  CollectionViewCell.swift
//  FlowImageApp
//
//  Created by Николай Петров on 15.05.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var activituIndicator: UIActivityIndicatorView!
    @IBOutlet var cellImage: UIImageView!
    var indexPath: IndexPath!
    var asyncIndex: Int!
    
    func configureCell(imageData: ImageData, index: IndexPath) {
        indexPath = index
        activituIndicator.startAnimating()
        activituIndicator.hidesWhenStopped = true
        
        StorageData.shared.fetchCachImage(with: imageData.url,
                                     imageView: cellImage) { image in
            self.asyncIndex = index.row
            guard let image = image else {
                self.placeholder()
                return
            }
            self.equalsAsync(image)
        }
        
        errorHandling()
    }
    
    //Check that image belong cell
    private func equalsAsync(_ image: UIImage) {
        if self.asyncIndex == self.indexPath.row {
            self.cellImage.image = image
            self.activituIndicator.stopAnimating()

        }
    }
    
    //Handling Error 503
    func errorHandling() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            if self.activituIndicator.isAnimating == true {
                self.placeholder()
            }
        }
    }
    
    func placeholder() {
        cellImage.image = UIImage(named: "notFound")
        activituIndicator.stopAnimating()
    }
    
    
}
