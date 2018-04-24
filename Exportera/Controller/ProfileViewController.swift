//
//  ProfileViewController.swift
//  Exportera
//
//  Created by Marina Lunts on 4/9/18.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class ProfileViewController: UIViewController {

    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var telNumLabel: UILabel!
    
    var ref: DatabaseReference!
    var currentUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        getUserInfo()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getUserInfo(){
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.currentUser.email = value?["email"] as? String ?? ""
            self.currentUser.firstName = value?["firstname"] as? String ?? ""
            self.currentUser.lastName = value?["lastname"] as? String ?? ""
            self.currentUser.city = value?["city"] as? String ?? ""
            self.currentUser.telNumber = Int(value?["telnumber"] as? String ?? "")
            //self.performSegue(withIdentifier: "goToProfile", sender: self)
             self.updateUIWithUserData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    func updateUIWithUserData() {
        nameField.text = "\(currentUser.firstName!) \(currentUser.lastName!)"
        cityLabel.text = currentUser.city
        telNumLabel.text = "Номер телефона: +\(currentUser.telNumber!)"
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
