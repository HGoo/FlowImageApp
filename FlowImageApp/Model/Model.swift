//
//  Model.swift
//  FlowImageApp
//
//  Created by Николай Петров on 16.05.2022.
//

import Foundation

struct ImageData: Codable {
    let imageName: String
    let lat: Float
    let long: Float
    let url: String
}


