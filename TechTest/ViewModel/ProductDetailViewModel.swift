//
//  File.swift
//  TechTest
//
//  Created by Chirag Chaplot on 28/7/21.
//

import Foundation

class ProductDetailViewModel {
    private var name, brand, brandName: String?
    private var description: String?
    private var features: [Feature]?
    private var lastUpdated: String?
    private var eligibility: [Eligibility]?
    private var productID: String?
    var request : ProductDetailAPI
    var apiLoader : APILoader<ProductDetailAPI>
    
    
    func setUp(product:ProductDetailResponse){
        name = product.data.name
        description = product.data.dataDescription
        features = product.data.features
        lastUpdated = product.data.lastUpdated
        brand = product.data.brand
        brandName = product.data.brandName
        productID = product.data.productID
        if let eligList = product.data.eligibility {
            eligibility = eligList
        }
    }
    
    init(productID: String) {
        self.productID = productID
        self.request = ProductDetailAPI(productID: productID)
        self.apiLoader = APILoader(apiHandler: request)
    }
    
    func getName() -> String {
        if let name = self.name {
            return name
        }
        else {
            return "Product Detail"
        }
    }
    
    func getDescription() -> HeaderItem {
        var sublist = [SFSymbolItem]()
        if let description = description {
        let symbolItem  = SFSymbolItem(name: description)
        sublist.append(symbolItem)
        }
        return HeaderItem(title: "Product Category", symbols: sublist)
    }
    
    func getFeatures() -> HeaderItem {
        
        var sublist = [SFSymbolItem]()
        if let features = features {
            var symbolItem: SFSymbolItem
            for feature in features {
                
                if let additionalInfo = feature.additionalInfo {
                    symbolItem = SFSymbolItem(name: additionalInfo)
                    sublist.append(symbolItem)
                }
            }
        }
        return HeaderItem(title: "Features", symbols: sublist)
    }
    
    
    func getBrand() -> HeaderItem {
        var sublist = [SFSymbolItem]()
        if let brand = brand {
            let symbolItem  = SFSymbolItem(name: brand)
            sublist.append(symbolItem)
        }
        return HeaderItem(title: "Brand", symbols: sublist)
    }
    
    func getBrandName() -> HeaderItem {
        var sublist = [SFSymbolItem]()
        if let brandName = brandName {
            let symbolItem  = SFSymbolItem(name: brandName)
            sublist.append(symbolItem)
        }
        return HeaderItem(title: "Brand Name", symbols: sublist)
    }
    
    func getEligibility() -> HeaderItem {
        var symbolItem: SFSymbolItem
        var sublist = [SFSymbolItem]()
        
        if let eligibleList = eligibility {
            for eligible in eligibleList {
                
                if let additionalInfo = eligible.additionalInfo {
                    symbolItem = SFSymbolItem(name: additionalInfo)
                    sublist.append(symbolItem)
                }
            }
        }
        return HeaderItem(title: "Eligbility", symbols: sublist)
    }
    
    
    
    func getProductDetails (productID: String, param: [String: Any], completion: @escaping (ProductDetailResponse?, ServiceError?) -> ()) {
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let _ = error {
                completion(nil, error)
            } else {
                completion(model, nil)
            }
        }
    }
    
    
}
