//
//  ProductDetailAPITests.swift
//  TechTestTests
//
//  Created by Chirag Chaplot on 4/8/21.
//

import Foundation
import XCTest
@testable import TechTest

class ProductDetailAPITests: XCTestCase {

    func test_apiRequest() {
        let api = ProductDetailAPI(productID: "mockContent")
        let params = [:] as [String:Any?]
        let request = api.makeRequest(from: params)
        
        XCTAssertNotNil(request)
        XCTAssertNotNil(request?.url)
        XCTAssertEqual(request?.url?.scheme, "https")
        XCTAssertEqual(request?.url?.host, "api.commbank.com.au")
    }
    
    func test_apiParsingLogic() {
        let api = ProductDetailAPI(productID: "mockContent")
        
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(Helper().dummyProductDetailResponse()),
           let url = URL(string: APIPath().productDetail(productID: "mockContent")),
           let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "", headerFields: nil) {
            let response = try? api.parseResponse(data: jsonData, response: response)
            XCTAssertEqual(response?.data.brand,"CBA")
            XCTAssertEqual(response?.data.brandName,"CommBank Loans")
            XCTAssertEqual(response?.data.name,"Home Loan")
            XCTAssertEqual(response?.data.dataDescription,"Home loan for us")
            XCTAssertEqual(response?.data.productID,"mockContent")
            XCTAssertEqual(response?.data.features.count,1)
        }
    }

}
