//
//  ProductListAPITests.swift
//  TechTestTests
//
//  Created by Chirag Chaplot on 4/8/21.
//

import Foundation
import XCTest
@testable import TechTest

class ProductListAPITests: XCTestCase {

    func test_apiRequest() {
        let api = ProductListAPI()
        let params = [:] as [String:Any?]
        let request = api.makeRequest(from: params)
        
        XCTAssertNotNil(request)
        XCTAssertNotNil(request?.url)
        XCTAssertEqual(request?.url?.scheme, "https")
        XCTAssertEqual(request?.url?.host, "api.commbank.com.au")
    }
    
    func test_apiParsingLogic() {
        let api = ProductListAPI()
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(Helper().dummyProductResponse()),
           let url = URL(string: APIPath().productList),
           let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "", headerFields: nil) {
            let response = try? api.parseResponse(data: jsonData, response: response)
            XCTAssertEqual(response?.meta.totalPages, 1)
            XCTAssertEqual(response?.meta.totalRecords, 50)
            XCTAssertEqual(response?.data.products.count, 3)
        }
    }
}
