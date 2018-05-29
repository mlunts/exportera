//
//  OrderDetailViewController.swift
//  Exportera
//
//  Created by Marina Lunts on 29.05.2018.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class OrderDetailViewController: UIViewController {

    var detailedOrder: Order?
    var keyOrder : String?
//    var orderReference: DatabaseReference?
//    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadOrder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBOutlet weak var cityLabel: UILabel!
    
    func loadOrder(){
        cityLabel.text = "До: \(String(describing: keyOrder))"
    }
    
    
}
