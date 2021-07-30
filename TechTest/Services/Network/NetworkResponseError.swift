//
//  NetworkResponseError.swift
//  TechTest
//
//  Created by Chirag Chaplot on 28/7/21.
//

import Foundation

enum NetworkResponseError: String, Error {
    case decodingDataCorrupted = "Decoding Error: Data corruoted."
    case decodingKeyNotFound = "Decoding Error: Decoding key not found"
    case decodingValueNotFound = "Decoding Error: Decoding value not found"
    case decodingTypeMismatch = "Decoding Error: Type mismatch"
}
