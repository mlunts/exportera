//
//  User.swift
//  Exportera
//
//  Created by Marina Lunts on 4/12/18.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import Foundation

class User: NSObject {
    var email : String?
    var firstName : String?
    var lastName : String?
    var city : String?
    var telNumber : Int?
//    var licenseNumber : String?
//    var carNumber : String?
//    var insuranceTerm : Date?
//    
//    init(email: String?, firstName: String?, lastName : String?, city : String?, telNumber : Int?) {
//        //self.id = id
//        self.email = email
//        self.firstName = firstName
//        self.lastName = lastName
//        self.city = city
//        self.telNumber = telNumber
//    }
    
    func getFirstName() -> String {
        return firstName!
    }
    

}
