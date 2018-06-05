//
//  OrdersListViewController.swift
//  Exportera
//
//  Created by Marina Lunts on 24.04.2018.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import UIKit
import Firebase


class OrdersListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var documents: [DataSnapshot] = []
    
    var orders = [Order]()
    var selectedOrderId: String?
    var selectedOrder: Order?
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getOrders()
    }
    
    func getOrders() {
        ref.child("orders").observe(.childAdded, with: { (snapshot) in
            guard let order = Order.order(from: snapshot) else { return }
            self.orders.append(order)
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "goToMap") {
            let svc = segue.destination as! MapViewController
            svc.detailedOrder = selectedOrder
        }
        
        if (segue.identifier == "btnInfoSegue") {
            let svc = segue.destination as! OrderDetailViewController
            svc.detailedOrder = selectedOrder
            svc.keyOrder = selectedOrderId
        }
//        if (segue.identifier == "goToMap") {
//            let svc = segue.destination as! MapViewController
//            svc.detailedOrder = selectedOrder
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedOrder = orders[indexPath.row]
        selectedOrderId = orders[indexPath.row].idOrder
        let alert = UIAlertController(title: "Are you sure?", message: "Please confirm your action", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (UIAlertAction)in
            self.performSegue(withIdentifier: "goToMap", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    //
    
    
    @IBAction func detailsButton(_ sender: UIButton) {
        var superView = sender.superview
        while !(superView is UITableViewCell) {
            superView = superView?.superview
        }
        let cell = superView as! UITableViewCell
        if let indexpath = tableView.indexPath(for: cell){
            selectedOrder = orders[indexpath.row]
            selectedOrderId = orders[indexpath.row].idOrder
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "OrderViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? OrderViewCell  else {
            fatalError("The dequeued cell is not an instance of OrderTableViewCell.")
        }
        
        let order = orders[indexPath.row]
        cell.priceLabel.text = "$\(order.price ?? 0)"
        cell.cityLabel.text = order.destination
        
        return cell
    }
    
    @IBAction func optionButton(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive , handler:{ (UIAlertAction)in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController1")
            self.present(nextViewController, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
    }
    
    
}
