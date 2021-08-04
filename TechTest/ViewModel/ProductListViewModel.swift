//
//  ProductListViewModel.swift
//  TechTest
//
//  Created by Chirag Chaplot on 25/7/21.
//

import Foundation

class ProductListViewModel {
    
    var productViewModels = [ProductViewModel]()
    var request = ProductListAPI()
    var apiLoader : APILoader<ProductListAPI>
    
    func modelAt(_ index: Int) -> ProductViewModel {
        return productViewModels[index]
        
    }
    
    init(productList: ProductResponse?, request: ProductListAPI =  ProductListAPI()){
        if let productList = productList {
            for product in productList.data.products {
                let productVM = ProductViewModel(product: product)
                productViewModels.append(productVM)
            }
        }
        self.request = request
        apiLoader = APILoader<ProductListAPI>(apiHandler: request)
    }
    
    func fetchProductList(param: [String: Any], completion: @escaping (ProductResponse?, ServiceError?) -> ()) {
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
