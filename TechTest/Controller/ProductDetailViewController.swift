//
//  ProductDetailViewController.swift
//  TechTest
//
//  Created by Chirag Chaplot on 27/7/21.
//

import Foundation
import UIKit

class ProductDetailViewController: UIViewController {
    
    var productID: String = ""
    var productDetailVM: ProductDetailViewModel?

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<HeaderItem, ListItem>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        load()        
        print("Chirag - ProductDetailViewController")
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Create list layout
    func  collectionViewLayoutSetUp() {
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        layoutConfig.headerMode = .firstItemInSection
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)

        // MARK: Configure collection view
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: listLayout)
    }
    
    
    func load()
    {
        productDetailVM?.getProductDetails(productID: self.productID, param: [:], completion: { (model,error) in
           if let _ = error {
               DispatchQueue.main.async {
                   let alert = UIAlertController(title: "Error", message: error?.message, preferredStyle: UIAlertController.Style.alert)
                   self.present(alert, animated: true, completion: nil)
               }
           } else {
               if let productDetailResponse = model {
                self.productDetailVM?.setUp(product: productDetailResponse)
                DispatchQueue.main.async {
                   self.display()
                }
               }
           }
       })
    }
    
    func display()
    {
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.title = productDetailVM?.getName()
        collectionViewLayoutSetUp()
        view.addSubview(collectionView)
        setUpLayout()
        cellReg()
        setUpSnapShots()
    }
    
    func setUpLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
        ])
    }
    
    
    private func cellReg() {
        let headerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, HeaderItem> {
            (cell, indexPath, headerItem) in
            
            var content = cell.defaultContentConfiguration()
            content.text = headerItem.title
            cell.contentConfiguration = content
            
            //Accessibility
            cell.isAccessibilityElement = false
            
            let headerDisclosureOption = UICellAccessory.OutlineDisclosureOptions(style: .header)
            cell.accessories = [.outlineDisclosure(options:headerDisclosureOption)]
        }

        let symbolCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SFSymbolItem> {
            (cell, indexPath, symbolItem) in
            
            var content = cell.defaultContentConfiguration()
            content.text = symbolItem.name
            cell.contentConfiguration = content
            
            //Accessibility
            cell.isAccessibilityElement = true
            cell.accessibilityLabel = symbolItem.name
            cell.accessibilityValue = symbolItem.name
        }
        
        dataSource = UICollectionViewDiffableDataSource<HeaderItem, ListItem>(collectionView: collectionView) {
            (collectionView, indexPath, listItem) -> UICollectionViewCell? in
            
            switch listItem {
            case .header(let headerItem):
            
                let cell = collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration,
                                                                        for: indexPath,
                                                                        item: headerItem)
                return cell
            
            case .symbol(let symbolItem):
                
                let cell = collectionView.dequeueConfiguredReusableCell(using: symbolCellRegistration,
                                                                        for: indexPath,
                                                                        item: symbolItem)
                return cell
            }
        }
    }
    
    private func setUpSnapShots(){
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<HeaderItem, ListItem>()

        let modelObjects = prepareListObject()
        dataSourceSnapshot.appendSections(modelObjects)
        dataSource.apply(dataSourceSnapshot)
        
        for headerItem in modelObjects {
            
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<ListItem>()
            
            let headerListItem = ListItem.header(headerItem)
            sectionSnapshot.append([headerListItem])
            
            let symbolListItemArray = headerItem.symbols.map { ListItem.symbol($0) }
            sectionSnapshot.append(symbolListItemArray, to: headerListItem)
            
            sectionSnapshot.expand([headerListItem])
            
            dataSource.apply(sectionSnapshot, to: headerItem, animatingDifferences: false)
        }

    }
    
    private func prepareListObject() -> [HeaderItem]{
        var list = [HeaderItem]()
        
        if let description = productDetailVM?.getDescription() {
            list.append(description)
        }

        if let featuresList = productDetailVM?.getFeatures()  {
            list.append(featuresList)
        }

        if let brand = productDetailVM?.getBrand() {
            list.append(brand)
        }

        if let brandName = productDetailVM?.getBrandName() {
            list.append(brandName)
        }

        if let eligibility = productDetailVM?.getEligibility() {
            list.append(eligibility)
        }
        
        return list
    }
}
