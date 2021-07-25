//
//  ProductListViewModel.swift
//  TechTest
//
//  Created by Chirag Chaplot on 25/7/21.
//

import Foundation

class ProductListViewModel {
    init(productList: ProductResponse) {
        print(productList.meta.totalRecords)
        print(productList.meta.totalPages)
//        print(productList.data.products.count)
    }
}
