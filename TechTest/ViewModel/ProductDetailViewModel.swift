//
//  File.swift
//  TechTest
//
//  Created by Chirag Chaplot on 28/7/21.
//

import Foundation

class ProductDetailViewModel {
    private var name: String
    private var description: String
    private var features: [Feature]
    private var lastUpdated: String
    
    init(_ product:ProductDetailResponse){
        name = product.data.name
        description = product.data.dataDescription
        features = product.data.features
        lastUpdated = product.data.lastUpdated
        print("Chirag ProductDetailViewModel",lastUpdated)
    }
    
    func getName() -> String {
        return name
    }
    
    func getDescription() -> String {
        return description
    }
    func getFeatures() -> [Feature] {
        return features
    }
    func getLastUpdated() -> String {
        return lastUpdated
    }
    
}
