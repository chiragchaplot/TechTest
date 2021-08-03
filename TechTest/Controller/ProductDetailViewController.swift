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
    private var productDetailVM: ProductDetailViewModel?

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
//        print("Chirag ProductID", productID)
//        let productDetailLoader = ProductDetailLoaderURL(productID: productID)
//        let productDetailResource = productDetailLoader.getProductResource()
//        
//        Webservice().load(resource: productDetailResource) { [weak self] (result) in
//            if let productDetailResource = result {
//                self?.productDetailVM = ProductDetailViewModel(productDetailResource)
//                self?.display()
//            }
//        }
    }
    
    func display()
    {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = productDetailVM?.getName()
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
            
            // Set headerItem's data to cell
            var content = cell.defaultContentConfiguration()
            content.text = headerItem.title
            cell.contentConfiguration = content
            
            // Add outline disclosure accessory
            // With this accessory, the header cell's children will expand / collapse when the header cell is tapped.
            let headerDisclosureOption = UICellAccessory.OutlineDisclosureOptions(style: .header)
            cell.accessories = [.outlineDisclosure(options:headerDisclosureOption)]
        }

        let symbolCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SFSymbolItem> {
            (cell, indexPath, symbolItem) in
            
            // Set symbolItem's data to cell
            var content = cell.defaultContentConfiguration()
            content.text = symbolItem.name
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<HeaderItem, ListItem>(collectionView: collectionView) {
            (collectionView, indexPath, listItem) -> UICollectionViewCell? in
            
            switch listItem {
            case .header(let headerItem):
            
                // Dequeue header cell
                let cell = collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration,
                                                                        for: indexPath,
                                                                        item: headerItem)
                return cell
            
            case .symbol(let symbolItem):
                
                // Dequeue symbol cell
                let cell = collectionView.dequeueConfiguredReusableCell(using: symbolCellRegistration,
                                                                        for: indexPath,
                                                                        item: symbolItem)
                return cell
            }
        }
    }
    
    private func setUpSnapShots(){
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<HeaderItem, ListItem>()

        // Create collection view section based on number of HeaderItem in modelObjects
        let modelObjects = prepareListObject()
        dataSourceSnapshot.appendSections(modelObjects)
        dataSource.apply(dataSourceSnapshot)
        
        // Loop through each header item so that we can create a section snapshot for each respective header item.
        for headerItem in modelObjects {
            
            // Create a section snapshot
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<ListItem>()
            
            // Create a header ListItem & append as parent
            let headerListItem = ListItem.header(headerItem)
            sectionSnapshot.append([headerListItem])
            
            // Create an array of symbol ListItem & append as child of headerListItem
            let symbolListItemArray = headerItem.symbols.map { ListItem.symbol($0) }
            sectionSnapshot.append(symbolListItemArray, to: headerListItem)
            
            // Expand this section by default
            sectionSnapshot.expand([headerListItem])
            
            // Apply section snapshot to the respective collection view section
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
