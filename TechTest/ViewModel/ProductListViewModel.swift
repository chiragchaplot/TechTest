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
        }
    }
    
    func fetchProductList(param: [String: Any], completion: @escaping (ProductResponse?, ServiceError?) -> ()) {
        let request = ProductListAPI()
        
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let _ = error {
                completion(nil, error)
            } else {
                completion(model, nil)
            }
        }
    }
    
    func getProductList() -> [ProductListCell] {
        var symbolItem: ProductListCell
        var list = [ProductListCell]()
        for product in productViewModels {
            symbolItem = ProductListCell(name: product.name, productID: product.productID)
            list.append(symbolItem)
        }
        return list
    }
}
