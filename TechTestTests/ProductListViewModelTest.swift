//
//  ProductListViewModel.swift
//  TechTestTests
//
//  Created by Chirag Chaplot on 4/8/21.
//

import XCTest
@testable import TechTest

class ProductListViewModelTest: XCTestCase {
    var productListViewModel = ProductListViewModel(productList: nil)
    var helper = Helper()
    
    override func setUp() {
        super.setUp()
    }
    
    // MARK:- Test for empty Product List
    
    
    // MARK:- Test for filled Product List
    func test_modelAt() {
        productListViewModel = ProductListViewModel(productList: Helper().dummyProductResponse())
        XCTAssertEqual(productListViewModel.productViewModels.count, 3)
        let prodVM =  productListViewModel.modelAt(0)
        XCTAssertEqual(prodVM.name, "Credit Card")
        XCTAssertEqual(prodVM.productID,  "11")
    }
    
   
    func test_getProducts() {
        productListViewModel = ProductListViewModel(productList: Helper().dummyProductResponse())
        let list = productListViewModel.getProductList()
        
        XCTAssertNotNil(list)
        XCTAssertEqual(list.count,3)
        XCTAssertEqual(list[0].name,"Credit Card")
    }
    
    func test_fetchProducts() {
        productListViewModel.request = mockProductListAPI()
        let expection = self.expectation(description: "loading of product")
        productListViewModel.fetchProductList(param: [:], completion: {
            (response, error) in
            
            if let prodResponse = response {
                self.productListViewModel = ProductListViewModel(productList: prodResponse)
                expection.fulfill()
            }
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(productListViewModel.productViewModels.count,25)
    }
}
