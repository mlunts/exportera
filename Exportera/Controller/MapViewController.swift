//
//  MapViewController.swift
//  Exportera
//
//  Created by Marina Lunts on 24.04.2018.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var detailedOrder: Order?
    
    //    @IBOutlet weak var mapView: UIView!
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var locManager = CLLocationManager()
    
    var destinationLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        getCoordinates()
        loadLabels()
        loadMap()
    }
    
    
    private func loadMap() {
        LocationManager.sharedInstance.getReverseGeoCodedLocation(address: (detailedOrder?.destination)!, completionHandler: { (location:CLLocation?, placemark:CLPlacemark?, error:NSError?) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            if placemark == nil {
                print("Location can't be fetched")
                return
            }
            
            self.destinationLocation = placemark?.location
            
            print(self.destinationLocation.coordinate)
            
            self.getRoute()
        })
    }
    
    func getRoute() {
        map.delegate = self
        map.showsScale = true
        map.showsPointsOfInterest = true
        map.showsUserLocation = true
        
        locManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyBest
            locManager.startUpdatingLocation()
        }
        
        let sourceCoordinates = locManager.location?.coordinate
        let destCoordinates = CLLocationCoordinate2DMake(destinationLocation.coordinate.latitude, destinationLocation.coordinate.longitude)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates!)
        let destPlacemark = MKPlacemark(coordinate: destCoordinates)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destItem = MKMapItem(placemark: destPlacemark)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceItem
        directionRequest.destination = destItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: {
            response, error in
            
            guard let response = response else {
                if let error = error {
                    print("wrong")
                }
                return
            }
            
            let route = response.routes[0]
            self.map.add(route.polyline, level: .aboveRoads)
            
            let rekt = route.polyline.boundingMapRect
            self.map.setRegion(MKCoordinateRegionForMapRect(rekt), animated: true)
        })
    }
    
    private func loadLabels() {
        cityLabel.text = "Destination: \(detailedOrder?.destination ?? "city")"
        distanceLabel.text = "Distance: \(detailedOrder?.distance ?? 982)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func errorButton(_ sender: Any) {
        guard let number = URL(string: "tel://" + "838995") else { return }
        UIApplication.shared.open(number)
    }
    
    
    @IBAction func handleDelieveryGesture(_ sender: Any) {
        if (sender as AnyObject).state == UIGestureRecognizerState.began {
            let alertController = UIAlertController(title: nil, message:
                "Confirm your action", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Press", style: UIAlertActionStyle.default,handler: {
                (UIAlertAction)in
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "goToProfile") as! ProfileViewController
                self.present(nextViewController, animated: true, completion: nil)
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.black
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    
    
}
