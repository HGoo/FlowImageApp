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
    
    func fetchReview(pagination: Bool = false, urlString: String, completion: @escaping (UIImage, Error?) -> Void) {
        NetworkRequest.shared.requestData(urlString: urlString) { data in
            
            switch data {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let imageData = try decoder.decode(ImageData.self, from: data)
                    responce(imageData, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
                
            case .failure(let error):
                print("Error received reuesting data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
