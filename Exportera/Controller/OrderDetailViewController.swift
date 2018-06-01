//
//  OrderDetailViewController.swift
//  Exportera
//
//  Created by Marina Lunts on 29.05.2018.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController {

    var detailedOrder: Order?
    var keyOrder : String?
        @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var typeOfOrderLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var dimensionsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadOrder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func loadOrder(){
        print(detailedOrder?.typeOfOder?.rawValue)
        cityLabel.text = "До: \(detailedOrder?.destination ?? "Город")"
        priceLabel.text = "$\(detailedOrder?.price ?? 0)"
        typeOfOrderLabel.text = "Тип заказа: \(detailedOrder?.typeOfOder)"
        weightLabel.text = "Вес груза: \(detailedOrder?.weightOfCargo ?? 0) кг"
        dimensionsLabel.text = "Габариты груза: \(detailedOrder?.dimensions?.length) х \(detailedOrder?.dimensions?.width) x \(detailedOrder?.dimensions?.height)"
    }
    
}
