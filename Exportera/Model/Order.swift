//
//  Order.swift
//  Exportera
//
//  Created by Marina Lunts on 4/20/18.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation

class Order: NSObject {
    
    var ref: DatabaseReference?
    
    var idOrder : String?
    var price: Double?
    var destination : String?
    var distance : Double?
    var typeOfOder: OrderType?
    var weightOfCargo : Double?
    var dimensions : Dimensions?
    var customerNumber : Int?
    var deliveredInfo : DeliveredInfo?
    var status : StatusType?

    
    public func updateOrder(status: StatusType?) {
        self.status = status
    }
    
    public func setDistance(distance: Double?) {
        self.distance = distance
    }
    
    init?(destination: String, price: String, idOrder: String, typeOfOder: String, weightOfCargo: String, dimensions: Dimensions, customerNumber: String) {
        self.ref = nil
        self.idOrder = idOrder
        self.price = Double(price)
        self.destination = destination
        self.typeOfOder = OrderType(rawValue: typeOfOder)
        self.weightOfCargo = Double(weightOfCargo)
        self.dimensions = dimensions
        self.customerNumber = Int(customerNumber)
    }
    
    static func order(from snapshot: DataSnapshot) -> Order? {
        let orderDict = snapshot.value as? [String : AnyObject] ?? [:]
        guard let destination = orderDict["pointOfDeparture"] as? String,
            let price =  orderDict["price"] as? String,
            let idOrder = snapshot.key as? String,
            let typeOfOder = orderDict["typeOfOrder"] as? String,
            let weightOfCargo = orderDict["weightOfCargo"] as? String,
            let length = orderDict["length"] as? String,
            let width = orderDict["width"] as? String,
            let height = orderDict["height"] as? String,
            let customerNumber = orderDict["customerNumber"] as? String
            else { return nil }
        let dimensions = Dimensions(height: height, length: length, width: width)
        let order = Order(destination: destination, price: price, idOrder: idOrder, typeOfOder: typeOfOder, weightOfCargo: weightOfCargo, dimensions: dimensions, customerNumber: customerNumber)
        
        return order
    }
    
}
