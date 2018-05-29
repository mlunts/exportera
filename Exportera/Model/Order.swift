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
    
    var ref: DatabaseReference?
    
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

    init?(destination: String, price: String, idOrder: String = "") {
        self.ref = nil
        self.idOrder = idOrder
        self.price = price
        self.destination = destination
    }

    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let price = value["price"] as? String,
            let destination = value["pointOfDeparture"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.idOrder = snapshot.key
        self.price = price
        self.destination = destination
    }
    
    func toAnyObject() -> Any {
        return [
            "price": price,
            "pointOfDeparture": destination
        ]
    }
    
    static func order(from snapshot: DataSnapshot) -> Order? {
        let orderDict = snapshot.value as? [String : AnyObject] ?? [:]
        guard let destination = orderDict["pointOfDeparture"] as? String,
            let price =  orderDict["price"] as? String,
            let idOrder = snapshot.key as? String
            else { return nil }
        let order = Order(destination: destination, price: price, idOrder: idOrder)
        return order
    }
}
