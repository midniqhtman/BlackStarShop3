//
//  ViewController.swift
//  BlackStarShop
//
//  Created by Байсаев Зубайр on 14.08.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var mainTableView: UITableView!
    
    var categories = [String]()
    var url = "https://fakestoreapi.com/products/categories"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loader = Network()
        loader.categoryLoad()
        loader.delegate = self
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        categories.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .boldSystemFont(ofSize: 24)
        header.textLabel?.text = "Категории"
        header.textLabel?.textAlignment = .center
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoriesTableViewCell
       
        let model = categories[indexPath.row]
        cell.textLabel?.text = model.capitalized
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController else { return }
        vc.categoryName = categories[indexPath.row]
        
        present(vc, animated: true)
    }
}

extension MainViewController: NetworkDelegate {
    func newLoaded(categories: [String]) {
     self.categories = categories
        mainTableView.reloadData()

    }
}
