//
//  OrdersListViewController.swift
//  Exportera
//
//  Created by Marina Lunts on 24.04.2018.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import UIKit
import Firebase

class OrdersListViewController: UIViewController {
    
    var orders = [Order]()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     ref = Database.database().reference() // инициализация БД
        
        getOrders()
    }
    
    func getOrders() {
        ref.child("orders").observe(.value, with: { (snapshot) in
            print(snapshot.value)
            
            self.orders = []
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                
                for snap in snapshots {
                    
                    // Make our jokes array for the tableView.
                    
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let order = Order(key: key, dictionary: postDictionary)
                        
                        // Items are returned chronologically, but it's more fun with the newest jokes first.
                        
                        self.orders.insert(order, at: 0)
                    }
                }
            }
        }){ (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return orders.count
//    }
    
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//
//        let order = orders[indexPath.row]
//
//        // We are using a custom cell.
//
//        if let cell = tableView.dequeueReusableCellWithIdentifier("JokeCellTableViewCell") as? JokeCellTableViewCell {
//
//            // Send the single joke to configureCell() in JokeCellTableViewCell.
//
//            cell.configureCell(joke)
//
//            return cell
//
//        } else {
//
//            return JokeCellTableViewCell()
//
//        }
//
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
