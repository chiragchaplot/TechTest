//
//  ViewController.swift
//  TechTest
//
//  Created by Chirag Chaplot on 25/7/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let baseUrl = URLGenerator.Urls.baseURL()
        var urlRequest = URLRequest(url: baseUrl)
        urlRequest.addValue("3", forHTTPHeaderField: "x-v")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = "GET"
        
        let productResource = Resource<ProductResponse>(urlRequest: urlRequest) { data in
            let productResponse = try? JSONDecoder().decode(ProductResponse.self, from: data)
            debugPrint(productResponse)
            return productResponse
        }
        
        Webservice().load(resource: productResource) { (result) in
            if let productResouce = result {
                //let productListViewModel = ProductListViewModel(productList: productResouce)
                //completion(productListViewModel)
            }
            
        }
    }
}

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
