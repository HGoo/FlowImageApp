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
    
    func fetchImage(urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        NetworkRequest.shared.requestData(urlString: urlString) { data in
            
            switch data {
            case .success(let (data, response)):
                completion(data, response, nil)
                
            case .failure(let error):
                print("Error received reuesting data: \(error.localizedDescription)")
                completion(nil, nil, error)
            }
        }
    }
}
