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

class MapViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var delegate: MapViewControllerDelegate?
    
    let locationManager = CLLocationManager()
    
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            let locValue = locationManager.location!.coordinate
            self.latitude = locValue.latitude
            self.longitude = locValue.longitude
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(locValue, 500, 500)
            let annotation = MKPointAnnotation()
            annotation.coordinate = locValue
            mapView.addAnnotation(annotation)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tempLabel.text = searchText
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let del = delegate {
            del.updatedLocation(with: self.latitude, longitude: self.longitude)
        }
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
