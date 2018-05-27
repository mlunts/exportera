//
//  Order.swift
//  Exportera
//
//  Created by Marina Lunts on 4/20/18.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import Foundation
import Firebase

class Order: NSObject {
    
    var orderRef: DatabaseReference
    
    var idOrder : String?
    var price: String?
    var destination : String?
    var distance : Double?
    var typeOfOder: OrderType?
    var weightOfCargo : Double?
    var dimensions : Dimensions?
    var customerNumber : Int?
    var deliveredInfo : DeliveredInfo?
    var status : StatusType?

    func updateOrder(status: StatusType?) {
        self.status = status
    }
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self.idOrder = key
        
        // Within the Joke, or Key, the following properties are children
        
        if let price = dictionary["price"] as? String {
            self.price = price
        }
        
        if let destination = dictionary["destination"] as? String {
            self.destination = destination
        } else {
            self.destination = ""
        }
        
        // The above properties are assigned to their key.
        
        self.orderRef = Database.database().reference().child("orders")
    }
    
    
//    func toJSON() -> [String: AnyObject]
//    
//    init(fromFirebaseItem: FIRDataSnapshot)
}
