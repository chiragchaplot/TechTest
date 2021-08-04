//
//  ProductDetailViewModelTest.swift
//  TechTestTests
//
//  Created by Chirag Chaplot on 4/8/21.
//

import XCTest
@testable import TechTest

class ProductDetailViewModelTest: XCTestCase {
    var prodDetailVM = Helper().dummyProductDetail()
    
    func test_getProductDetails() {
        prodDetailVM = ProductDetailViewModel(productID: "ad22b1f0967349e8a5d586afe7f0d845")
        let expection = self.expectation(description: "loading of product details")
        
        var prodDetailResponse = Helper().dummyProductDetailResponse()
        prodDetailVM.getProductDetails(productID: "ad22b1f0967349e8a5d586afe7f0d845", param: [:], completion: {
            (response,model) in
            if let prodDetails = response {
                prodDetailResponse = prodDetails
                expection.fulfill()
            }
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(prodDetailResponse.data.name,"NetBank Saver")
        XCTAssertEqual(prodDetailResponse.data.brand,"CBA")
        XCTAssertEqual(prodDetailResponse.data.brandName,"CommBank")
        XCTAssertEqual(prodDetailResponse.data.dataDescription,"An online savings account with the flexibility to move money in and out of your linked CommBank transaction account using NetBank or the CommBank app.")
        XCTAssertEqual(prodDetailResponse.data.isTailored,false)
    }
    
    func test_getName() {
        let name = prodDetailVM.getName()
        XCTAssertEqual(name,"Home Loan")
    }
    
    func test_getDescription() {
        let description = prodDetailVM.getDescription()
        XCTAssertEqual(description.title,"Product Category")
        XCTAssertEqual(description.symbols[0].name,"Home loan for us")
    }
}
