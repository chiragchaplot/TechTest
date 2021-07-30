//
//  ProductDetailViewController.swift
//  TechTest
//
//  Created by Chirag Chaplot on 27/7/21.
//

import Foundation
import UIKit

class ProductDetailViewController: UIViewController {
    
    var productID: String = ""
    private var productDetailVM: ProductDetailViewModel?
    
    var productName: UITextView  = {
        let textView = UITextView()
        textView.textAlignment = NSTextAlignment.center
        textView.textColor = UIColor.blue
        textView.backgroundColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.adjustsFontForContentSizeCategory = true
        return textView
    }()
    
    var productDescription: UITextView  = {
        let textView = UITextView()
        textView.textAlignment = NSTextAlignment.center
        textView.textColor = UIColor.blue
        textView.backgroundColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.adjustsFontForContentSizeCategory = true
        return textView
    }()
    
//    var productDescription: UITextView  = {
//        let textView = UITextView()
//        textView.textAlignment = NSTextAlignment.center
//        textView.textColor = UIColor.blue
//        textView.backgroundColor = UIColor.lightGray
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.isEditable = false
//        textView.font = .preferredFont(forTextStyle: .body)
//        textView.adjustsFontForContentSizeCategory = true
//        return textView
//    }()
    
    @IBAction func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        configureFonts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        configureFonts()
        print("Chirag - ProductDetailViewController")
        load()
    }
    
    func load()
    {
        print(productID)
        let productDetailLoader = ProductDetailLoaderURL(productID: productID)
        let productDetailResource = productDetailLoader.fetchProductDetails()
        
        Webservice().load(resource: productDetailResource) { [weak self] (result) in
            if let productDetailResource = result {
                self?.productDetailVM = ProductDetailViewModel(productDetailResource)
                self?.display()
            }
        }
    }
    
    func display()
    {
        self.productName.text = self.productDetailVM?.getName()
        self.productDescription.text = self.productDetailVM?.getDescription()
        self.view.addSubview(productName)
        self.view.addSubview(productDescription)
        setUpLayout()
    }
    
    func setUpLayout() {
        productName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        productName.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        productName.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        productName.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        productName.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true

        productDescription.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 50).isActive = true
        productDescription.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        productDescription.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        productDescription.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100).isActive = true
    }
    
    private func configureFonts(){
        productName.font = UIFont.preferredFont(forTextStyle: .body)
        productDescription.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    
}

extension ProductDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraints) in
            if constraints.firstAttribute == .height {
                constraints.constant = estimatedSize.height
            }
        }
    }
}
