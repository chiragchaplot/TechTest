//
//  URLGenerator.swift
//  TechTest
//
//  Created by Chirag Chaplot on 25/7/21.
//

import Foundation

struct URLGenerator {
    private func baseURL() -> String {
        return "https://api.commbank.com.au/public/cds-au/v1/banking/products"
    }
    
    func productList() -> URL {
        var url = baseURL()
        let pageCount = "?page_count=1000"
        url = url + pageCount
        return URL(string: url)!
    }
    
    func productDetail(productID: String) -> String {
        var url = baseURL()
        url = url + "/" + productID
        return url
    }
}
