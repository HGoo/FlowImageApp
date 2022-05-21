//
//  MainViewController.swift
//  FlowImageApp
//
//  Created by Николай Петров on 15.05.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var activituIndicator: UIActivityIndicatorView!
    @IBOutlet var selestedImage: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var descriptionLable: UILabel!
    
    private var selestedImageData: ImageData?
    var imagesData: [ImageData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    
    
    private func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        activituIndicator.hidesWhenStopped = true
        
        imagesData = DataLoader().imagesData
    }
    
    //    private func setupImageSize() {
    //        selestedImage.frame.size.height =  view.frame.size.height / 60
    //        selestedImage.frame.size.width =  10
    //
    //    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Web" {
            let webVC = segue.destination as! WebViewController
            webVC.imagesDataForWeb = selestedImageData
        }
    }
}

// MARK: - UICollectionViewDelegat

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        collectionView.deselectItem(at: indexPath, animated: true)
        //
        guard let imageData = imagesData?[indexPath.row] else { return }
        selestedImageData = imageData
        let url = imageData.url
        
        selestedImage.image = nil
        activituIndicator.startAnimating()
        descriptionLable.text = nil
        descriptionLable.text = imageData.imageName
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.pulse()
        
        StorageData.shared.fetchCachImage(with: url, imageView: selestedImage) { [weak self] image, error in
            guard let self = self else { return }
            if error == nil {
                self.selestedImage.image = image
                self.activituIndicator.stopAnimating()
            }
            
        }
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
