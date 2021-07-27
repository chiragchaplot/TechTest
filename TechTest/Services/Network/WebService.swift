//
//  WebService.swift
//  TechTest
//
//  Created by Chirag Chaplot on 25/7/21.
//

import Foundation

struct Resource<T> {
    let urlRequest: URLRequest
    let parse: (Data) -> T?
}

final class Webservice {
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        URLSession.shared.dataTask(with: resource.urlRequest) { data, response, error in
            
            if let data  = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            }
                else {
                    completion(nil)
                }
            }.resume()
        }
    }
