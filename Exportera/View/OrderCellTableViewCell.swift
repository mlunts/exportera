//
//  OrderCellTableViewCell.swift
//  Exportera
//
//  Created by Marina Lunts on 27.05.2018.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//


import UIKit
import Firebase

class OrderCellTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    var order: Order!

    
    func configureCell(order: Order) {
        self.order = order
        
        // Set the labels and textView.
        
        self.cityLabel.text = order.destination
        self.priceLabel.text = "$ \(order.price)"

    }
    
}


