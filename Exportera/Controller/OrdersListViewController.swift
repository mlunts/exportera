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
        if (segue.identifier == "btnInfoSegue") {
            let svc = segue.destination as! OrderDetailViewController
            svc.detailedOrder = selectedOrder
            svc.keyOrder = selectedOrderId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedOrder = orders[indexPath.row]
        selectedOrderId = orders[indexPath.row].idOrder
        print(selectedOrderId)
        let alert = UIAlertController(title: "Вы хотите взять данный заказ?", message: "Подтвердите действие", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (UIAlertAction)in
            self.performSegue(withIdentifier: "goToMap", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        
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
            print(selectedOrderId)
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
    
    
    
}
