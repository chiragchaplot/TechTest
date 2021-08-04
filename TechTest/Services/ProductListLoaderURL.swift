//
//  ProductListLoader.swift
//  TechTest
//
//  Created by Chirag Chaplot on 26/7/21.
//

import Foundation

struct ProductListAPI: APIHandler {
    func makeRequest(from param: [String: Any]) -> URLRequest? {
        let urlString =  APIPath().productList
        if var url = URL(string: urlString) {
            if param.count > 0 {
                url = setQueryParams(parameters: param, url: url)
            }
            var urlRequest = URLRequest(url: url)
            setDefaultHeaders(request: &urlRequest)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> ProductResponse {
        return try defaultParseResponse(data: data,response: response)
    }
}
