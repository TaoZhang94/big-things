//
//  MapViewController.swift
//  Big Things
//
//  Created by Zhang, Tao - zhaty039 on 30/11/19.
//  Copyright © 2019 Zhang, Tao - zhaty039. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
        self.setMap(locations: annotationLocations)
        self.checkLocationServices()
    }
    
    var annotationLocations = [[String : Any]]()
    
    let dataManager = DataManager.sharedDataManager
    let locationManager = CLLocationManager()
    
    //set the user location manager
    func setUpLocationManager(){
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    //Ask for authorities
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setUpLocationManager()
            checkLocationAuthorization()
        }
            
        else{
           let alert = UIAlertController(title: "Location service is disable", message: "Please Enable the location service to continue", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    //Check the authorities
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            mapView.showsUserLocation = true
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
            
            
        }
    }
    
    //Load data from the stored big things
    func loadData(){
    
        let dataArray = dataManager.bigThingArr
        var index = 0
        
        for bigThing in dataArray{
            
            var tempDictionary: [String : Any]
            
            let longitude = Double(bigThing.longitude)
            let latitude = Double(bigThing.latitude)
            
            tempDictionary = ["title" : bigThing.name, "longitude" : longitude, "latitude" : latitude]
            annotationLocations.append(tempDictionary)
            
            index += 1
        }
        
    }
    
    //set the map based on big thing`s name and location
    func setMap(locations: [[String : Any]]){

        for location in locations{

            let annocation = MKPointAnnotation()

            annocation.title = location["title"] as? String
        
            annocation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
            mapView.addAnnotation(annocation)

        }
    }
}
