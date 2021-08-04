//
//  File.swift
//  TechTestTests
//
//  Created by Chirag Chaplot on 4/8/21.
//

import Foundation
@testable import TechTest

struct Helper {
    let HelperList = ["Credit Card", "Home Loan", "Car Loan"]
    
    
    func returnProductViewModel_Many() -> [ProductViewModel] {
        var result = [ProductViewModel]()
        for item in HelperList {
            let prod = Product(productID: String(item.count), name: item)
            result.append(ProductViewModel(product: prod))
        }
        return result
    }
    
    func returnProducts() -> [Product] {
        var result = [Product]()
        for item in HelperList {
            let prod = Product(productID: String(item.count), name: item)
            result.append(prod)
        }
        return result
    }
    
    func dummyProductResponse() -> ProductResponse {
        let products = Helper().returnProducts()
        let data = DataClass(products: products)
        let link = Links(linksSelf: "", first: "", next: "", last: "")
        let meta = Meta(totalRecords: 50, totalPages: 1)
        return ProductResponse(data: data, links: link, meta: meta)
    }
    
    func dummyProductDetailResponse() -> ProductDetailResponse {
        let feature = Feature(featureType: "TEST", additionalValue: "TEST", additionalInfo: "This is a test value", additionalInfoURI: "")
        var features = [Feature]()
        features.append(feature)
        let data = ProductDetailDataClass(features: features, eligibility: nil, productID: "mockContent", lastUpdated: "", productCategory: "LOAN", name: "Home Loan", dataDescription: "Home loan for us", brand: "CBA", brandName: "CommBank Loans", isTailored: false, fees: nil)
        
        return ProductDetailResponse(data: data)
    }
}
