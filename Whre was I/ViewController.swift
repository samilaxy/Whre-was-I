//
//  ViewController.swift
//  Whre was I
//
//  Created by Samuel Noye on 04/05/2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        updateSavePin()

    }
 
    @IBAction func saveBtnClicked(_ sender: UIBarButtonItem) {
        let coord = locationManager.location?.coordinate
        guard let lat = coord?.latitude, let long = coord?.longitude else {
            print("Location not found")
            return
        }
        print("lat:\(lat) and long:\(long)")
        DataStore().StoredDataPoint(latitude: String(lat), longitude: String(long))
       
        updateSavePin()
        
    }
    func updateSavePin () {
        if let oldCoords = DataStore().GetLastLocation() {
             
            let annoRem = mapView.annotations.filter{$0 !== mapView.userLocation}
            mapView.removeAnnotations(annoRem)
            
            let annotation = MKPointAnnotation()
            annotation.title = "I was here"
            annotation.subtitle = "remember!"
            
            annotation.coordinate.latitude = Double(oldCoords.latitude)!
            annotation.coordinate.longitude = Double(oldCoords.longitude)!
            mapView.addAnnotation(annotation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status ==  .authorizedWhenInUse else {
            print("Location not enabled")
            return
        }
        print("Location allowed")
        mapView.showsUserLocation = true
    }

}

