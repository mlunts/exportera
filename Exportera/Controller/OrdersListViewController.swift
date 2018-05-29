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
    var selectedOrder: Order?
    var selectedOrderId: String?
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
    
    @IBAction func detailsClicked(_ sender: Any) {
//        let orderDetailVC = OrderDetailViewController()
//        orderDetailVC.detailedOrder = selectedOrder
        performSegue(withIdentifier: "goToDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails", let order = selectedOrder {
            let orderDetailVC = segue.destination as! OrderDetailViewController
//                  orderDetailVC.cityLabel = order.destination
            orderDetailVC.detailedOrder = order
            orderDetailVC.keyOrder = selectedOrderId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedOrder = orders[indexPath.row]
        selectedOrderId = orders[indexPath.row].idOrder
        //        performSegue(withIdentifier: "goToDetails", sender: self)
    }
    
    
    @IBAction func orderClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "Вы хотите взять данный заказ?", message: "Подтвердите действие", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (UIAlertAction)in
            self.performSegue(withIdentifier: "goToMap", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        
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
        
        cell.priceLabel.text = "$\(order.price ?? "0")"
        cell.cityLabel.text = order.destination
        
        return cell
    }
    
    
    
}
