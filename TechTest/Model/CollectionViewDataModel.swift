//
//  CollectionViewDataMoel.swift
//  TechTest
//
//  Created by Chirag Chaplot on 30/7/21.
//

import Foundation

enum Section {
    case main
}

enum ListItem: Hashable {
    case header(HeaderItem)
    case symbol(SFSymbolItem)
}

struct HeaderItem: Hashable {
    let title: String
    let symbols: [SFSymbolItem]
}

struct SFSymbolItem: Hashable {
    let uuid: UUID
    let name: String
    init(name: String) {
        self.name = name
        self.uuid = UUID()
    }
}

struct ProductListCell: Hashable {
    let name: String
    let productID: String
    
    init(name: String, productID: String) {
        self.name = name
        self.productID = productID
    }
}
