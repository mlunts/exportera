//
//  LoginViewController.swift
//  Exportera
//
//  Created by Marina Lunts on 4/8/18.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var ref: DatabaseReference!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                print("log in successful")
            }
        }
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let email = value?["email"] as? String ?? ""
            let firstName = value?["firstname"] as? String ?? ""
            let lastName = value?["lastname"] as? String ?? ""
            
            let user = User(email: email, firstName: firstName, lastName: lastName)
            print(user.firstName as Any)
            
            let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
            vc.currentUser = "hgfh"
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            //self.performSegue(withIdentifier: "goToProfile", sender: self)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    
    // убирается клавиатура при нажатии в любой точке экрана
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
