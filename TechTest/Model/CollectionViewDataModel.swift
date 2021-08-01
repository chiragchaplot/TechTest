//
//  CollectionViewDataMoel.swift
//  TechTest
//
//  Created by Chirag Chaplot on 30/7/21.
//

import Foundation

enum ListItem: Hashable {
    case header(HeaderItem)
    case symbol(SFSymbolItem)
}

struct HeaderItem: Hashable {
    let title: String
    let symbols: [SFSymbolItem]
}

struct SFSymbolItem: Hashable {
    let name: String
    init(name: String) {
        self.name = name
        
    }
}
