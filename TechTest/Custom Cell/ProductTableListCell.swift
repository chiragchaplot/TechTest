//
//  ProductTableListCell.swift
//  TechTest
//
//  Created by Chirag Chaplot on 26/7/21.
//

import Foundation
import UIKit

class ProductTableListCell: UITableViewCell {
    
    @IBOutlet weak var productName: UILabel!
    
    func configure(_ productViewModel: ProductViewModel)
    {
        self.productName.text = productViewModel.name
    }
}
