//
//  RequestHandler+Extension.swift
//  TechTest
//
//  Created by Chirag Chaplot on 3/8/21.
//

import Foundation
// MARK: Request Handler Supporting methods

extension RequestHandler {
    
    func setQueryParams(parameters:[String: Any], url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map { element in URLQueryItem(name: element.key, value: String(describing: element.value) ) }
        return components?.url ?? url
    }
    
    func setDefaultHeaders(request: inout URLRequest) {
        request.setValue(Constants.APIHeaders.contentTypeValue, forHTTPHeaderField: Constants.APIHeaders.kContentType)
        request.setValue(Constants.APIHeaders.xvValue, forHTTPHeaderField: Constants.APIHeaders.kXV)
    }
}

