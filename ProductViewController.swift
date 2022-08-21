//
//  ProductViewController.swift
//  BlackStarShop
//
//  Created by Байсаев Зубайр on 15.08.2022.
//

import UIKit

protocol ProductViewControllerDelegate {
    func loadId(id: String)
}

class ProductViewController: UIViewController {

    var idDelegate: ProductViewControllerDelegate?
    var product: [Product] = []
    var categoryName = " "
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        newProductLoad()

    }
    
    //MARK: Loading of products
    func newProductLoad() {
        let urlString = "https://fakestoreapi.com/products/category/\(categoryName)"
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
            let products = try JSONDecoder().decode([Product].self, from: data)
                        DispatchQueue.main.async {
                            self.product = products
                            self.collectionView.reloadData()
        }
    }
            catch {
                print(error)
            }
        }.resume()
        }
    }
 
extension ProductViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        let model = product[indexPath.item]
        cell.priceLabel.text = String(model.price) + " " + "USD"
        cell.nameLabel.text = model.title
        
        if let url = URL(string: model.image) {
        
            if let data = NSData(contentsOf: url), let imageFromData = UIImage(data: data as Data ) {
                
                cell.imageOfProduct?.image = imageFromData
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsTableViewController else {
            fatalError("Unable to Instantiate Prodyct View Controller")
        }
       
        let model = product[indexPath.item]
       
        detailsViewController.name = model.title
        detailsViewController.price = String(round(model.price)) + " " + "USD"
        detailsViewController.detDes = model.description
        detailsViewController.product = [model]
        detailsViewController.image = model.image
        detailsViewController.categoryNameDetails = categoryName
 
            present(detailsViewController, animated: true)
    }
        
}

