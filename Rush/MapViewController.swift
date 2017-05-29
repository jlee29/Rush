//
//  MapViewController.swift
//  Rush
//
//  Created by Jiwoo Lee on 5/20/17.
//  Copyright © 2017 DolphinDevs. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol MapViewControllerDelegate {
    func updatedLocation(with latitude: Double, longitude: Double)
}

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var delegate: MapViewControllerDelegate?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            let locValue = locationManager.location!.coordinate
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(locValue, 500, 500)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let del = delegate {
            del.updatedLocation(with: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        }
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
