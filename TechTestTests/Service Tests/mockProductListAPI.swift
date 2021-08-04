//
//  mockProductListAPI().swift
//  TechTestTests
//
//  Created by Chirag Chaplot on 4/8/21.
//

import Foundation
@testable import TechTest

class mockProductListAPI: ProductListAPI {
    
    private var urlRequest: URLRequest
    
    override func makeRequest(from param: [String: Any]) -> URLRequest? {
        setHttpMethod()
        setHeaders()
        return urlRequest
    }
    
    override func parseResponse(data: Data, response: HTTPURLResponse) throws -> ProductResponse {
        return Helper().dummyProductResponse()
    }
    
    internal func setHttpMethod() {
        urlRequest.httpMethod = HTTPMethod.get.rawValue
    }

    internal func setHeaders() {
        self.urlRequest.addValue("3", forHTTPHeaderField: "x-v")
        self.urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    }
    
    override init() {
        let url = URL(string: "https://api.commbank.com.au/public/cds-au/v1/banking/products?page_count=1000")
        urlRequest = URLRequest(url: url!)
    }
}
