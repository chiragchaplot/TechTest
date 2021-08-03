//
//  ProductListTableViewController.swift
//  TechTest
//
//  Created by Chirag Chaplot on 25/7/21.
//

import Foundation
import UIKit

class ProductListViewController: UIViewController {
    
    var productListVM = ProductListViewModel(productList: nil)
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, ProductListCell>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, ProductListCell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Product List"
        load()
    }
    
    func load() {
            productListVM.fetchProductList(param: [:], completion: { (model,error) in
                if let _ = error {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: error?.message, preferredStyle: UIAlertController.Style.alert)
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    if let prodListVM = model {
                        self.productListVM = ProductListViewModel(productList: prodListVM)
                        DispatchQueue.main.async {
                            self.display()
                        }
                    }
                }
            })
    }
    
    func display()
    {
        setUpLayouts()
        setUpConstraints()
        cellRegistration()
        applyAccessibility()
    }
    
    func setUpLayouts() {
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: listLayout)
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    func setUpConstraints() {
        // Make collection view take up the entire view
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0.0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
        ])
    }
    
    func cellRegistration() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ProductListCell> { (cell, indexPath, item) in
            
            var content = cell.defaultContentConfiguration()
            content.text = item.name
            cell.contentConfiguration = content
            
            //Accessibility for Cell
            cell.isAccessibilityElement = true
            cell.accessibilityHint = "Double Tap To View Product Details"
            cell.accessibilityLabel = "Product Type"
            cell.accessibilityValue = item.name
            cell.accessibilityTraits = .selected
        }
        
        
        dataSource = UICollectionViewDiffableDataSource<Section, ProductListCell>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: ProductListCell) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            cell.accessories = [.disclosureIndicator()]
            
            return cell
        }
        
        snapshot = NSDiffableDataSourceSnapshot<Section, ProductListCell>()
        snapshot.appendSections([.main])
        snapshot.appendItems(productListVM.getProductList(), toSection: .main)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
    
    func applyAccessibility() {
        collectionView.isAccessibilityElement = false
        collectionView.shouldGroupAccessibilityChildren = true
    }
}

extension ProductListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else {
            collectionView.deselectItem(at: indexPath, animated: true)
            return
        }
        collectionView.deselectItem(at: indexPath, animated: true)
        let productDetailViewController = storyboard?.instantiateViewController(identifier: "ProductDetailViewController") as! ProductDetailViewController
        productDetailViewController.productID = selectedItem.productID
        productDetailViewController.productDetailVM = ProductDetailViewModel(productID: selectedItem.productID)
        present(productDetailViewController, animated: true)
    }
}

