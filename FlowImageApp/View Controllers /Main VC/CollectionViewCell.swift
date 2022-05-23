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
    
    private var indexPath: IndexPath!
    private var asyncIndex: Int!
    static let shared = CollectionViewCell()
    
    
    func configureCell(imageData: ImageData, index: IndexPath) {
        indexPath = index
        setupCell()
        
        StorageData.shared.fetchCachImage(with: imageData.url,
                                          imageView: cellImage) { [weak self] image, error in
            guard let self = self else { return }
            if error == nil {
                self.asyncIndex = index.row
                guard let image = image else {
                    self.placeholder()
                    return
                }
                self.equalsAsync(image)
            }
        }
        
        errorHandling()
    }
    
    private func setupCell() {
        activituIndicator.startAnimating()
        activituIndicator.hidesWhenStopped = true
        
        // Dublicate bug fix
        if cellImage.image != UIImage(named: "notFound") {
            cellImage.image = nil
        }
        
    }
    
    //Check that image belong cell
    private func equalsAsync(_ image: UIImage) {
        if self.asyncIndex == self.indexPath.row {
            self.cellImage.image = image
            self.activituIndicator.stopAnimating()
            
        }
    }
    
    //Handling Error 503
    private func errorHandling() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 61) { [weak self] in
            guard let self = self else { return }
            if self.activituIndicator.isAnimating == true {
                self.placeholder()
            }
        }
    }
    
    private func placeholder() {
        cellImage.image = UIImage(named: "notFound")
        activituIndicator.stopAnimating()
    }
    
    func pulseAmimationCell() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.95
        pulse.toValue = 1
        layer.add(pulse, forKey: nil)
    }
}
