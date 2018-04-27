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
//    var ref = Database.database().reference()
    
    let snapshot: DataSnapshot
    var key: String {
        return snapshot.key
    }
    var ref: DatabaseReference {
        return snapshot.ref
    }
    
    required init(snapshot: DataSnapshot) {
        
        self.snapshot = snapshot
        
        super.init()
        
        for child in snapshot.children.allObjects as? [DataSnapshot] ?? [] {
            if responds(to: Selector(child.key)) {
                setValue(child.value, forKey: child.key)
            }
        }
    }
    
    
    
    
}
