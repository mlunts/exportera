//
//  User.swift
//  Exportera
//
//  Created by Marina Lunts on 4/12/18.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import Foundation
import Firebase

class User: NSObject {
    var id : String?
    var email : String?
    var firstName : String?
    var lastName : String?
    var city : String?
    var telNumber : Int?
    var licenseNumber : String?
    var carNumber : String?
    var insuranceTerm : Date?
    
    func getId() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            self.id = snapshot.key
        }, withCancel: nil)
    }
    
    
    init(firstName: String) {
        self.firstName = firstName
    }
    

}
