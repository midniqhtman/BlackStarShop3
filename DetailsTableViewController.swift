//
//  DetailsTableViewController.swift
//  BlackStarShop
//
//  Created by Байсаев Зубайр on 18.08.2022.
//

import UIKit
import RealmSwift

class DetailsTableViewController: UITableViewController {

    let realm = try! Realm()
    
    var name = " "
    var price = " "
    var detDes = " "
    var product: [Product] = []
    var image = " "
    var categoryNameDetails = " "
    
    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var detailsPrice: UILabel!
    @IBOutlet weak var detailsName: UILabel!
    @IBAction func addToBasket(_ sender: Any) {
        
        let realmBasket = ProductList()
        
        realmBasket.name = name
        realmBasket.price = price
        realmBasket.image = image
        
        try! realm.write {
            realm.add(realmBasket)
        }
    }
    @IBOutlet weak var detailsDescription: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCategoryViewController" {
        let vc = segue.destination as! ProductViewController
        vc.categoryName = categoryNameDetails
        } else { return }
    }
    // Для перехода на предыдущий экран через стрелку
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsPrice.text! = price
        detailsDescription.text! = detDes
        detailsName.text! = name
        
        if let url = URL(string: image) {
        
                    if let data = NSData(contentsOf: url), let imageFromData = UIImage(data: data as Data ) {
        
                        detailsImage.image = imageFromData
                    }
        detailsImage.clipsToBounds = true
          
    }
    // MARK: - Table view data source

        func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
}

}
