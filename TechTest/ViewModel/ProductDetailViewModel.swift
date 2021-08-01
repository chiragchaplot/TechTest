//
//  File.swift
//  TechTest
//
//  Created by Chirag Chaplot on 28/7/21.
//

import Foundation

class ProductDetailViewModel {
    private var name, brand, brandName: String
    private var description: String
    private var features: [Feature]
    private var lastUpdated: String
    private var eligibility: [Eligibility]?
    
    
    init(_ product:ProductDetailResponse){
        name = product.data.name
        description = product.data.dataDescription
        features = product.data.features 
        lastUpdated = product.data.lastUpdated
        brand = product.data.brand
        brandName = product.data.brandName
        if let eligList = product.data.eligibility {
            eligibility = eligList
        }
    }
    
    func getName() -> String {
        return name
    }
    
    func getDescription() -> HeaderItem {
        let symbolItem  = SFSymbolItem(name: description)
        var sublist = [SFSymbolItem]()
        sublist.append(symbolItem)
        return HeaderItem(title: "Product Category", symbols: sublist)
    }
    
    func getFeatures() -> HeaderItem {
        var symbolItem: SFSymbolItem
        var sublist = [SFSymbolItem]()
        
        for feature in features {
            
            if let additionalInfo = feature.additionalInfo {
                symbolItem = SFSymbolItem(name: additionalInfo)
                sublist.append(symbolItem)
            }
        }
        return HeaderItem(title: "Features", symbols: sublist)
    }
    
    
    func getBrand() -> HeaderItem {
        let symbolItem  = SFSymbolItem(name: brand)
        var sublist = [SFSymbolItem]()
        sublist.append(symbolItem)
        return HeaderItem(title: "Brand", symbols: sublist)
    }
    
    func getBrandName() -> HeaderItem {
        let symbolItem  = SFSymbolItem(name: brandName)
        var sublist = [SFSymbolItem]()
        sublist.append(symbolItem)
        return HeaderItem(title: "Brand Name", symbols: sublist)
    }
    
    func getLastUpdated() -> HeaderItem {
        let symbolItem  = SFSymbolItem(name: brand)
        var sublist = [SFSymbolItem]()
        sublist.append(symbolItem)
        return HeaderItem(title: "Last Updated", symbols: sublist)
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
    
    
    
}
