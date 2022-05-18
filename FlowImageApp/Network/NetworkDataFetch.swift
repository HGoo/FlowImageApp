//
//  NetworkDataFetch.swift
//  FlowImageApp
//
//  Created by Николай Петров on 17.05.2022.
//

import Foundation
import UIKit

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    
    private init() {
        
    }
    
    func fetchImage(urlString: String, completion: @escaping (UIImage?, Error?) -> ()) {
        NetworkRequest.shared.requestData(urlString: urlString) { data in
            
            switch data {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                completion(image, nil)
                
            case .failure(let error):
                print("Error received reuesting data: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
    }
}
