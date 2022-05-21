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
    var imagesDataForWeb: ImageData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRequest()
    }
    
    private func loadRequest() {
        guard let imageUrl =  imagesDataForWeb?.url else { return }
        guard let url = URL(string: imageUrl) else { return }
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        
    }
}
