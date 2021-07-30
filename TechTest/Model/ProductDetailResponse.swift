//
//  ProductDetailResponse.swift
//  TechTest
//
//  Created by Chirag Chaplot on 27/7/21.
//
import Foundation

// MARK: - ProductDetailResponse
struct ProductDetailResponse: Codable {
    let data: ProductDetailDataClass
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

// MARK: - DataClass
struct ProductDetailDataClass: Codable {
    let features: [Feature]
    let eligibility: [Eligibility]
    let productID: String
    let lastUpdated, productCategory, name, dataDescription: String
    let brand, brandName: String
    let isTailored: Bool
    

    enum CodingKeys: String, CodingKey {
        case features, eligibility
        case productID = "productId"
        case lastUpdated, productCategory, name
        case dataDescription = "description"
        case brand, brandName
        case isTailored
    }
}

// MARK: - AdditionalInformation
struct AdditionalInformation: Codable {
    let overviewURI: String
    let termsURI: String
    let eligibilityURI, feesAndPricingURI: String

    enum CodingKeys: String, CodingKey {
        case overviewURI = "overviewUri"
        case termsURI = "termsUri"
        case eligibilityURI = "eligibilityUri"
        case feesAndPricingURI = "feesAndPricingUri"
    }
}

// MARK: - DepositRate
struct DepositRate: Codable {
    let depositRateType, rate, calculationFrequency, applicationFrequency: String
}

// MARK: - Eligibility
struct Eligibility: Codable {
    let eligibilityType: String
    let additionalValue, additionalInfo: String?
}

// MARK: - Feature
struct Feature: Codable {
    let featureType: String
    let additionalValue, additionalInfo: String?
    let additionalInfoURI: String?

    enum CodingKeys: String, CodingKey {
        case featureType, additionalValue, additionalInfo
        case additionalInfoURI = "additionalInfoUri"
    }
}

// MARK: - Fee
struct Fee: Codable {
    let name, feeType, amount: String
}

// MARK: - Links
struct ProductDetailLinks: Codable {
    let linksSelf: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - Meta
struct ProductDetailMeta: Codable {
    let totalRecords, totalPages: Int
}
