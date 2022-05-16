//
//  DataLoader.swift
//  FlowImageApp
//
//  Created by Николай Петров on 16.05.2022.
//

import Foundation

public class DataLoader {
    init() {
        loadJson()
    }
    
   @Published var imagesData = [ImageData]()
    
    func loadJson(){
        
        guard let fileLocation = Bundle.main.url(forResource: "imageData", withExtension: "json")
        else { return}
        do {
            let data = try Data(contentsOf: fileLocation)
            let decoder = JSONDecoder()
            let dataFromJson = try decoder.decode([ImageData].self, from: data)
            
            self.imagesData = dataFromJson
        } catch {
            print(error)
        }
    }
}

