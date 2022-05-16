//
//  CollectionViewCell.swift
//  FlowImageApp
//
//  Created by Николай Петров on 15.05.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var cellImage: UIImageView!
    var indexPath: IndexPath!
    var asyncIndex: Int!
    
    func configureCell(imageData: ImageData, index: IndexPath) {
        indexPath = index
        
        StorageData().fetchCachImage(with: imageData.url,
                                     imageView: cellImage) { image in
            self.asyncIndex = index.row
            self.equalsAsync(image)
        }
        
        
    }
    
    //Check that image belong cell
    private func equalsAsync(_ image: UIImage) {
        if self.asyncIndex == self.indexPath.row {
            self.cellImage.image = image
        }
    }
}
