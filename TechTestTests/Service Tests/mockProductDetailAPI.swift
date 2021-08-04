//
//  mockProductDetailAPI.swift
//  TechTestTests
//
//  Created by Chirag Chaplot on 4/8/21.
//

import Foundation
@testable import TechTest

class mockProductDetailAPI: APIHandler {
    
    private var urlRequest: URLRequest
    private var productID: String
    
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        setHttpMethod()
        setHeaders()
        return urlRequest
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> ProductResponse {
        return Helper().dummyProductResponse()
    }
    
    internal func setHttpMethod() {
        urlRequest.httpMethod = HTTPMethod.get.rawValue
    }

    internal func setHeaders() {
        self.urlRequest.addValue("3", forHTTPHeaderField: "x-v")
        self.urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    }
    
    init(productID: String) {
        self.productID = productID
        let url = URL(string: "https://api.commbank.com.au/public/cds-au/v1/banking/products/\(productID)")
        urlRequest = URLRequest(url: url!)
    }
}
