//
//  ProductListTableViewController.swift
//  TechTest
//
//  Created by Chirag Chaplot on 25/7/21.
//

import Foundation
import UIKit

protocol ProductDetailDelegate {
    func showProductDetails(productID: String)
}

class ProductListTableViewController: UITableViewController {
    
    var productListVM:ProductListViewModel
    
    var delegate: ProductDetailDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        print("Chirag - ProductListTableViewController")
        load()
    }
    
    func load()
    {
        let productListLoader = ProductListLoaderURL()
        let productResource = productListLoader.getProductList()
        
        Webservice().load(resource: productResource) { [weak self] (result) in
            if let productResource = result {
                self?.productListVM = ProductListViewModel(productList: productResource)
                self?.tableView.reloadData()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.productListVM = ProductListViewModel(productList: nil)
        super.init(coder: aDecoder)
    }
}

extension ProductListTableViewController {
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProductDetailViewController{
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            destination.productID = productListVM.modelAt(index).productID
        }
    }
}
