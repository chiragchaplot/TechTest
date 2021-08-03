//
//  ResponseHandler+Extension.swift
//  TechTest
//
//  Created by Chirag Chaplot on 3/8/21.
//

import Foundation
// MARK: Response Handler - parse default

extension ResponseHandler {
    func defaultParseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T {
        let jsonDecoder = JSONDecoder()
        do {
            let body = try jsonDecoder.decode(T.self, from: data)
            if response.statusCode == 200 {
                return body
            } else {
                throw ServiceError(httpStatus: response.statusCode, message: "Unknown Error")
            }
        } catch  {
            throw ServiceError(httpStatus: response.statusCode, message: error.localizedDescription)
        }
        
    }
}

enum NetworkResponseError: String, Error {
    case decodingDataCorrupted = "Decoding Error: Data corruoted."
    case decodingKeyNotFound = "Decoding Error: Decoding key not found"
    case decodingValueNotFound = "Decoding Error: Decoding value not found"
    case decodingTypeMismatch = "Decoding Error: Type mismatch"
}

struct ServiceError: Error,Codable {
    let httpStatus: Int
    let message: String
}
