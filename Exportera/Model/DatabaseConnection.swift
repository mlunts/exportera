//
//  DatabaseConnection.swift
//  Exportera
//
//  Created by Marina Lunts on 4/20/18.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class DatabaseConnection: NSObject {
    
   // var user = User()
//    var ref: DatabaseReference! // референс к БД
    var ref = Database.database().reference()
    
    
    func getUserInfo() -> Any? {
        var user = User()
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            user.email = value?["email"] as? String ?? ""
            user.firstName = value?["firstname"] as? String ?? ""
            user.lastName = value?["lastname"] as? String ?? ""
            user.city = value?["city"] as? String ?? ""
            user.telNumber = Int(value?["telnumber"] as? String ?? "")
            //self.performSegue(withIdentifier: "goToProfile", sender: self)
        }) { (error) in
            print(error.localizedDescription)
        }
        return user
    }
    
}
