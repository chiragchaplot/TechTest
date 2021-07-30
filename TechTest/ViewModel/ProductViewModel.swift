//
//  ProductViewModel.swift
//  TechTest
//
//  Created by Chirag Chaplot on 25/7/21.
//

import Foundation

class ProductViewModel {
    let product : Product
    
    init (product: Product)
    {
        self.product = product
    }
    
    var name : String {
        return product.name
    }
    
    var productID: String {
        return product.productID
    }
}
