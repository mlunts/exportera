////
////  DatabaseConnection.swift
////  Exportera
////
////  Created by Marina Lunts on 4/20/18.
////  Copyright © 2018 Marina Lunts. All rights reserved.
////
//
//import Foundation
//import Firebase
//
//class UserService {
//
//    static var currentUserProfile:User?
//
//    static func observeUserProfile(_ uid:String, completion: @escaping ((_ user:User?)->())) {
//        let userRef = Database.database().reference().child("users/profile/\(uid)")
//
//        userRef.observe(.value, with: { snapshot in
//            var user:User?
//
//            if let dict = snapshot.value as? [String:Any],
//                let email = dict["email"] as? String,
//                let firstName = dict["firstname"] as? String,
//            let lastName = dict["lastname"] as? String {
//
//                user = User(uid: snapshot.key, email: email, firstName: firstName)
//            }
//
//            completion(user)
//        })
//    }
//
//}
