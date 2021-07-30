//
//  URLRequestGenerator.swift
//  TechTest
//
//  Created by Chirag Chaplot on 25/7/21.
//

import Foundation

protocol UrlRequestGeneratorProperties {
    func setHttpMethod()
    func setHeaders()
    func getURLRequest() -> URLRequest
}

enum httpMethod: String, CaseIterable {
    case deleten = "DELETE"
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}
