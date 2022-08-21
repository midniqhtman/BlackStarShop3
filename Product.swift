//
//  Categories.swift
//  BlackStarShop
//
//  Created by Байсаев Зубайр on 14.08.2022.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let description: String
    let image: String
    let price: Double
    let title: String
    
    
    init?(data: NSDictionary){
        guard let title = data["title"] as? String,
              let description = data["description"] as? String,
              let image = data["image"] as? String,
              let price = data["price"] as? Double,
              let id = data["id"] as? Int
        else { return nil }
        self.title = title
        self.description = description
        self.image = image
        self.price = price
        self.id = id
    }
  
}
