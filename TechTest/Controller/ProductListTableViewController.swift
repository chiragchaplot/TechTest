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
        productListVM.getProductList(param: [:], completion: { (model,error) in
            if let _ = error {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: error?.message, preferredStyle: UIAlertController.Style.alert)
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                if let prodListVM = model {
                    self.productListVM = ProductListViewModel(productList: prodListVM)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        })
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
            destination.productDetailVM = ProductDetailViewModel(productID: productListVM.modelAt(index).productID)
        }
    }
}
