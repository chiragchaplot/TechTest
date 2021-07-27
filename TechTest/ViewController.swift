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
        let urlgenerator = URLGenerator()
        let baseUrl = urlgenerator.productList()
        var urlRequest = URLRequest(url: baseUrl)
        urlRequest.addValue("3", forHTTPHeaderField: "x-v")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = "GET"
        
        let productResource = Resource<ProductResponse>(urlRequest: urlRequest) { data in
            let productResponse = try? JSONDecoder().decode(ProductResponse.self, from: data)
            print(type(of: productResponse))
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
