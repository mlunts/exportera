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
    
    @IBOutlet weak var gifView: UIImageView!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        gifView.loadGif(name: "truck-animation")
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            if error != nil {
                print(error!)
                self.showAlert(title: "Error!", msg: "Please try again. The email address or password you provided is not correct.", actions: nil)
            } else {
                self.performSegue(withIdentifier: "goToProfile", sender: self)
            }
        }
    }
    
    func showAlert(title: String, msg: String, actions:[UIAlertAction]?) {
        
        var actions = actions
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        if actions == nil {
            actions = [UIAlertAction(title: "OK", style: .default, handler: nil)]
        }
        
        for action in actions! {
            alertVC.addAction(action)
        }
        
        if let rootVC = UIApplication.shared.delegate?.window??.rootViewController {
            rootVC.present(alertVC, animated: true, completion: nil)
        } else {
            print("Root view controller is not set.")
        }
    }
    
    
    // убирается клавиатура при нажатии в любой точке экрана
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
