//
//  ProductListLoader.swift
//  TechTest
//
//  Created by Chirag Chaplot on 26/7/21.
//

import Foundation

class ProductListLoader: UrlRequestGeneratorProperties {
    private var urlRequest: URLRequest

    internal func setHttpMethod() {
        urlRequest.httpMethod = httpMethod.get.rawValue
    }

    internal func setHeaders() {
        urlRequest.addValue("3", forHTTPHeaderField: "x-v")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    }

    func getURLRequest() -> URLRequest{
                setHttpMethod()
                setHeaders()
        return urlRequest
    }
    

    init() {
        let urlGenerator = URLGenerator()
        let url = urlGenerator.productList()
        urlRequest = URLRequest(url: url)
    }
}
