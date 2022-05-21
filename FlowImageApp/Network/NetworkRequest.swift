//
//  NetworkRequest.swift
//  FlowImageApp
//
//  Created by Николай Петров on 17.05.2022.
//

import Foundation

class NetworkRequest {
    static let shared = NetworkRequest()
    
    private init() {
        
    }
    
    func requestData(urlString: String, completion: @escaping (Result<(Data, URLResponse), Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                guard let responce = responce else { return }
                completion(.success((data, responce)))
            }
            
        }.resume()
    }
}
