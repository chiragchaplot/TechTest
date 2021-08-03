//
//  APIPath.swift
//  TechTest
//
//  Created by Chirag Chaplot on 3/8/21.
//

import Foundation

#if DEBUG
let environment = APIEnvironment.development
#else
let environment = APIEnvironment.development
#endif

let baseURL = environment.baseURL()

struct APIPath {
    
    var productList: String { return "\(baseURL)?page_count=1000"}
    
    func productDetail(productID: String) -> String {
        return baseURL + "/" + productID
    }
}


