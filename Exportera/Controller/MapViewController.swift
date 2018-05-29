//
//  MapViewController.swift
//  Exportera
//
//  Created by Marina Lunts on 24.04.2018.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import UIKit
import GoogleMaps


class MapViewController: UIViewController, GMSMapViewDelegate,  CLLocationManagerDelegate  {
    
    
    //    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var googleMaps: GMSMapView!
    
    var locationManager = CLLocationManager()
    //    var locationSelected = Location.startLocation
    var currentLocation: CLLocation?
    
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        //        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        //        mapView.isMyLocationEnabled = true
        //        view = mapView
        //
        //        let marker = GMSMarker()
        //        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        //        marker.title = "Sydney"
        //        marker.snippet = "Australia"
        //        marker.map = mapView
        
        
        
        self.googleMaps.delegate = self
        self.googleMaps?.isMyLocationEnabled = true
        self.googleMaps.settings.myLocationButton = true
        self.googleMaps.settings.compassButton = true
        self.googleMaps.settings.zoomGestures = true
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.googleMaps?.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
