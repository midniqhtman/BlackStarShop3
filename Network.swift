//
//  Network.swift
//  BlackStarShop
//
//  Created by Байсаев Зубайр on 14.08.2022.
//

import Foundation

protocol NetworkDelegate {
    func newLoaded(categories: [String] )
}

class Network {
    var delegate: NetworkDelegate?
    var categories = [String]()
    func categoryLoad() {
let urlString = "https://fakestoreapi.com/products/categories"
guard let url = URL(string: urlString) else { return }

URLSession.shared.dataTask(with: url) { data, response, error in
    if let error = error {
        print(error)
    }
    
    guard let data = data else {
        return
    }
        do
            {
    let categories = try JSONDecoder().decode([String].self, from: data)
    print(categories)
                DispatchQueue.main.async {
                
                self.categories = categories
                self.delegate?.newLoaded(categories: categories)
}
            }
    catch {
        print(error)
    }

}.resume()
}
    
}
