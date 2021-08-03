//
//  APIEnvironment.swift
//  TechTest
//
//  Created by Chirag Chaplot on 3/8/21.
//

import Foundation

enum APIEnvironment {
    case development
    case staging
    case production
    
    func baseURL () -> String {
        return domain()
    }
    
    func domain() -> String {
        switch self {
        case .development:
            return "https://api.commbank.com.au/public/cds-au/v1/banking/products"
        case .staging:
            return "https://api.commbank.com.au/public/cds-au/v1/banking/products"
        case .production:
            return "https://api.commbank.com.au/public/cds-au/v1/banking/products"
        }
    }
}
