//
//  WebViewController.swift
//  FlowImageApp
//
//  Created by Николай Петров on 20.05.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    @IBOutlet var imageNameLable: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var imageLink: UILabel!
    var imagesDataForWeb: ImageData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageNameLable.text = imagesDataForWeb?.imageName
        imageLink.text = imagesDataForWeb?.url
        
        
        loadRequest()
        loadimage()
    }
    
    @IBAction func goLink(_ sender: Any) {
        guard let dataWeb = imagesDataForWeb else { return }
        guard let url = URL(string: dataWeb.url) else { return }
        
        showAlerrt(message: dataWeb.url, url: url)
    }
    
    private func loadRequest() {
        guard let dataWeb =  imagesDataForWeb else { return }
        let url = "https://www.google.ru/maps/place/\(dataWeb.lat),\(dataWeb.long)"
        guard let url = URL(string: url) else { return }
        
        
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        
    }
    
    private func loadimage() {
        guard let imageUrl =  imagesDataForWeb?.url else { return }
        StorageData.shared.fetchCachImage(with: imageUrl,
                                          imageView: image) { [weak self] image, error in
            guard let self = self else { return }
            if error == nil {
                self.image?.image = image
            } else {
                self.image.image = UIImage(named: "notFound")
            }
                
            }
    }
    
    func showAlerrt(message: String, url: URL) {
        let alert = UIAlertController(title: "Follow the link?",
                                      message: message,
                                      preferredStyle: .alert)
        
        let goAction = UIAlertAction(title: "Go", style: .default) {_ in
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .destructive)
        
        alert.addAction(goAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
