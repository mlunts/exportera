//
//  OrderDetailViewController.swift
//  Exportera
//
//  Created by Marina Lunts on 29.05.2018.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import UIKit
import GoogleMaps

class OrderDetailViewController: UIViewController, GMSMapViewDelegate {
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    var pointLocation: CLLocation!
    var geocoder = CLGeocoder()
    
    var detailedOrder: Order?
    var keyOrder : String?
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var typeOfOrderLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var dimensionsLabel: UILabel!
    @IBOutlet weak var customerNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateDistance()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func calculateDistance() {
        locManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locManager.location
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            
            LocationManager.sharedInstance.getReverseGeoCodedLocation(address: (detailedOrder?.destination)!, completionHandler: { (location:CLLocation?, placemark:CLPlacemark?, error:NSError?) in
                if error != nil {
                    print((error?.localizedDescription)!)
                    return
                }
                
                if placemark == nil {
                    print("Location can't be fetched")
                    return
                }
                
                self.pointLocation = placemark?.location
                
                print((placemark?.location?.coordinate.latitude)!)
                print((placemark?.location?.coordinate.longitude)!)
                self.detailedOrder?.setDistance(distance: (((self.currentLocation.distance(from: self.pointLocation))/1000)*100).rounded()/100)
                
                self.loadOrder()
                self.loadMap()
               
            })
        } else { print("error")}
    }
    
    func loadMap() {
        let camera = GMSCameraPosition.camera(withLatitude: self.pointLocation.coordinate.latitude, longitude: pointLocation.coordinate.longitude, zoom: 6.0)
    
        let marker = GMSMarker(position: pointLocation.coordinate)
        marker.map = mapView
        mapView?.animate(to: camera)
    }
 
    func loadOrder(){
        cityLabel.text = "City: \(detailedOrder?.destination ?? "Город")"
        priceLabel.text = "$\(detailedOrder?.price ?? 0)"
        typeOfOrderLabel.text = "Type of order: \(detailedOrder?.typeOfOder?.getType.lowercased() ?? "груз")"
        weightLabel.text = "Wight: \(detailedOrder?.weightOfCargo ?? 0) kg"
        dimensionsLabel.text = "Size: \(detailedOrder?.dimensions?.length ?? 0) х \(detailedOrder?.dimensions?.width ?? 0) x \(detailedOrder?.dimensions?.height ?? 0)"
        customerNumberLabel.text = "Mobile number: \(detailedOrder?.customerNumber ?? 0000)"
        distanceLabel.text = "Distance: \(detailedOrder?.distance ?? 0) km"
    }
    
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "goToMap") {
            let svc = segue.destination as! MapViewController
            svc.detailedOrder = detailedOrder
        }
    }
    
}
