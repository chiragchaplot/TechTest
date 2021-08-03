//
//  ProductListLoader.swift
//  TechTest
//
//  Created by Chirag Chaplot on 26/7/21.
//

import Foundation

class ProductListLoaderURL: UrlRequestGeneratorProperties {
    private var urlRequest: URLRequest

    internal func setHttpMethod() {
        urlRequest.httpMethod = httpMethod.get.rawValue
    }

    internal func setHeaders() {
        urlRequest.addValue("3", forHTTPHeaderField: "x-v")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    }

    func getURLRequest() -> URLRequest{
                setHttpMethod()
                setHeaders()
        return urlRequest
    }
    
//    func getProductList() -> Resource<ProductResponse> {
//        return Resource<ProductResponse>(urlRequest: getURLRequest()) { data in
//           do {
//               let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
//               return productResponse
//           } catch let DecodingError.dataCorrupted(context) {
//               print("# Data corrupted: ", context.debugDescription)
//               print(context)
//               return nil
//           } catch let DecodingError.keyNotFound(key, context) {
//               print("# Key '\(key)' not found:", context.debugDescription)
//               print("# CodingPath:", context.codingPath)
//               return nil
//           } catch let DecodingError.valueNotFound(value, context) {
//               print("# Value '\(value)' not found:", context.debugDescription)
//               print("# CodingPath:", context.codingPath)
//               return nil
//           } catch let DecodingError.typeMismatch(type, context)  {
//               print("# Type '\(type)' mismatch:", context.debugDescription)
//               print("# CodingPath:", context.codingPath)
//               return nil
//           } catch {
//               return nil
//           }
//       }
//    }
    
    
    

    init() {
        let urlGenerator = URLGenerator()
        let url = urlGenerator.productList()
        urlRequest = URLRequest(url: url)
    }
}

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
