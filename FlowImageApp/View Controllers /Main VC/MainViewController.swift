//
//  MainViewController.swift
//  FlowImageApp
//
//  Created by Николай Петров on 15.05.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var selestedImage: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var descriptionLable: UILabel!
    
    var imagesData: [ImageData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        imagesData = DataLoader().imagesData
    }
    
//    private func setupImageSize() {
//        selestedImage.frame.size.height =  view.frame.size.height / 60
//        selestedImage.frame.size.width =  10
//
//    }
    
    

}

// MARK: - UICollectionViewDelegat

extension MainViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = imagesData?[indexPath.row].url
        
        selestedImage.image = nil
        StorageData.shared.fetchCachImage(with: url, imageView: selestedImage) { [weak self] image, error in
            guard let self = self else { return }
            if error == nil {
                self.selestedImage.image = image
            }
            
            
            
        }
        
        let cell = collectionView.cellForItem(at: indexPath)
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.95
        pulse.toValue = 1
//            pulse.autoreverses = true
//            pulse.initialVelocity = 0.5
//            pulse.damping = 1
        cell?.layer.add(pulse, forKey: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        guard let imageData = imagesData?[indexPath.row] else { return cell}
        cell.configureCell(imageData: imageData, index: indexPath)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellInRow = 3
        let sectionsInsert = 15
        let size = view.frame.size.width / CGFloat(cellInRow)
        let spacing = CGFloat(cellInRow + 1) * CGFloat(sectionsInsert) / CGFloat(cellInRow)
        return CGSize(width: size - spacing, height: size - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
