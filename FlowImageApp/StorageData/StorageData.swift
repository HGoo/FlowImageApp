//
//  StorageData.swift
//  FlowImageApp
//
//  Created by Николай Петров on 16.05.2022.
//

import Foundation
import UIKit

class StorageData {
    
    static let shared = StorageData()
    
    func fetchCachImage(with url: String?, imageView: UIImageView, _ completion: @escaping (UIImage?, Error?) -> ()) {
        guard let url = url else { return }
        guard let imageUrl = url.getURL() else {
            imageView.image = UIImage(named: "notFound")
            return
        }
        
        if let cachedImage = self.getCachedImage(url: imageUrl) {
            completion(cachedImage, nil)
            print("000000000000000000000")
            return
        }
        
        NetworkDataFetch.shared.fetchImage(urlString: url) { image, error in
            if error == nil {
                completion(image, nil)
                print("999999999999999999999")
            }
        }
    }
 
    func saveImageToCache(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
    
    func getCachedImage(url: URL) -> UIImage? {
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}

fileprivate extension String{
    func getURL() -> URL? {
        guard let url = URL(string: self) else { return nil }
        return url
    }
}

