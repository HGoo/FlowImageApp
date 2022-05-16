//
//  CollectionViewCell.swift
//  FlowImageApp
//
//  Created by Николай Петров on 15.05.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var cellImage: UIImageView!
    
    func configure() {
        cellImage.image = UIImage(named: "testImage")
    }
}
