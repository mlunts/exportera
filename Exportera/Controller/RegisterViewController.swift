//
//  RegisterViewController.swift
//  Exportera
//
//  Created by Marina Lunts on 4/8/18.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {

    var ref: DatabaseReference! // референс к БД
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference() // инициализация БД
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.emailField.text!, password: self.passwordField.text!) { (user, error) in
         
            if error != nil {
                print(error!)
                return
            }
                print("Registration succesfull")
            
            guard let uid = user?.uid else { //доступ к ID пользователя
                return
            }
            
            self.ref = Database.database().reference() // инициализация БД
            let usersReference = self.ref.child("users").child(uid)
            let values = ["firstname": self.firstNameField.text, "lastname": self.lastNameField.text, "email": self.emailField.text]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if let err = err {
                        print(err)
                        return
                    }
                    print("Saved user successfully into Firebase db")
                })
        }
    }
        
    
    
    // outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == emailField {
//            passwordTextField.becomeFirstResponder()
//        } else if textField ==  passwordField {
//            textField.resignFirstResponder()
//        }
//        return true
//    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
