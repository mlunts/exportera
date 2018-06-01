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
    var price: Double?
    var destination : String?
    var distance : String?
    var typeOfOder: OrderType?
    var weightOfCargo : Double?
    var dimensions : Dimensions?
    var customerNumber : Int?
    var deliveredInfo : DeliveredInfo?
    var status : StatusType?

    func updateOrder(status: StatusType?) {
        self.status = status
    }

    init?(destination: String, price: String, idOrder: String, typeOfOder: String, weightOfCargo: String) {
        self.ref = nil
        self.idOrder = idOrder
        self.price = Double(price)
        self.destination = destination
        self.typeOfOder = OrderType(rawValue: typeOfOder)
        self.weightOfCargo = Double(weightOfCargo)
    }

    
    func toAnyObject() -> Any {
        return [
            "price": price,
            "pointOfDeparture": destination,
            "typeOfOrder": typeOfOder,
            "weightOfCargo": weightOfCargo
        ]
    }
    
    static func order(from snapshot: DataSnapshot) -> Order? {
        let orderDict = snapshot.value as? [String : AnyObject] ?? [:]
        guard let destination = orderDict["pointOfDeparture"] as? String,
            let price =  orderDict["price"] as? String,
            let idOrder = snapshot.key as? String,
            let typeOfOder = orderDict["typeOfOrder"] as? String,
            let weightOfCargo = orderDict["weightOfCargo"] as? String
            else { return nil }
        let order = Order(destination: destination, price: price, idOrder: idOrder, typeOfOder: typeOfOder, weightOfCargo: weightOfCargo)

        return order
    }
}
