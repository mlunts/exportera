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
    
    var user = User()
    
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        getUserInfo()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUIWithUserData() {
        nameField.text = "\(user.firstName!) \(user.lastName!)"
        cityLabel.text = user.city
        telNumLabel.text = "Номер телефона: +\(user.telNumber!)"
    }
    
    func getUserInfo() {
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.user.email = value?["email"] as? String ?? ""
            self.user.firstName = value?["firstname"] as? String ?? ""
            self.user.lastName = value?["lastname"] as? String ?? ""
            self.user.city = value?["city"] as? String ?? ""
            self.user.telNumber = Int(value?["telnumber"] as? String ?? "")
        
            
            //self.performSegue(withIdentifier: "goToProfile", sender: self)
            
            self.updateUIWithUserData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
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
