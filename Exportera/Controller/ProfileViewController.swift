//
//  ProfileViewController.swift
//  Exportera
//
//  Created by Marina Lunts on 4/9/18.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import UIKit


class ProfileViewController: UIViewController {

    @IBOutlet weak var nameField: UILabel!
    
    var currentUser: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIWithUserData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUIWithUserData() {
        nameField.text = currentUser
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
