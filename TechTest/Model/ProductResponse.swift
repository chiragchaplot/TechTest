//
//  ProductResponse.swift
//  TechTest
//
//  Created by Chirag Chaplot on 25/7/21.

import Foundation

// MARK: - ProductResponse
struct ProductResponse: Codable {
    let data: DataClass
    let links: Links
    let meta: Meta
}

// MARK: - DataClass
struct DataClass: Codable {
    let products: [Product]
}

// MARK: - Product
struct Product: Codable {
    let productID: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case name
    }
}

// MARK: - Links
struct Links: Codable {
    let linksSelf, first, next, last: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case first, next, last
    }
}

// MARK: - Meta
struct Meta: Codable {
    let totalRecords, totalPages: Int
}

