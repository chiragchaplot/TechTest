//
//  ProductListViewModel.swift
//  TechTest
//
//  Created by Chirag Chaplot on 25/7/21.
//

import Foundation

class ProductListViewModel {
    
    var productViewModels = [ProductViewModel]()
    
    func numOfRows(_ section: Int) -> Int {
        return productViewModels.count
    }
    
    func modelAt(_ index: Int) -> ProductViewModel {
        return productViewModels[index]
    }
    
    init(productList: ProductResponse?) {
        if let productList = productList {
            for product in productList.data.products {
                let productVM = ProductViewModel(product: product)
                productViewModels.append(productVM)
            }
            print("productList",productList.data.products.count)
            print("productViewModels",productViewModels.count)
        }
    }
}
