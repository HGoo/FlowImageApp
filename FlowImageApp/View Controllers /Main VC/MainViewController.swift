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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selestedImage.image = UIImage(named: "testImage")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupImageSize()
    }
    
    private func setupImageSize() {
        selestedImage.frame.size.height =  view.frame.size.height / 60
        selestedImage.frame.size.width =  10
        
    }
    

}

// MARK: - UICollectionViewDelegat

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.configure()
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
