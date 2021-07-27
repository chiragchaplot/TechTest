//
//  ProductListTableViewController.swift
//  TechTest
//
//  Created by Chirag Chaplot on 25/7/21.
//

import Foundation
import UIKit

class ProductListTableViewController: UITableViewController {
    
    var productListVM:ProductListViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        print("Chirag - ProductListTableViewController")
        load()
    }
    
    func load()
    {
        let productListLoader = ProductListLoader()
        let productResource = Resource<ProductResponse>(urlRequest: productListLoader.getURLRequest()) { data in
            let productResponse = try? JSONDecoder().decode(ProductResponse.self, from: data)
                return productResponse
        }
        Webservice().load(resource: productResource) { [weak self] (result) in
            if let productResource = result {
                self?.productListVM = ProductListViewModel(productList: productResource)
                self?.tableView.reloadData()
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListVM.numOfRows(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableListCell
        let productVM = productListVM.modelAt(indexPath.row)
        cell.configure(productVM)
        print(productVM.productID)
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.productListVM = ProductListViewModel(productList: nil)
        super.init(coder: aDecoder)
    }
}
