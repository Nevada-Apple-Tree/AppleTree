//
//  MapViewController.swift
//  AppleTree
//
//  Created by user188190 on 4/9/21.
//

import UIKit
import MapKit
import Parse

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }
    @IBAction func sendLocationBtnPressed(_ sender: Any) {
        let current = PFUser.current();
        let geo = PFGeoPoint()
        
    
        PFGeoPoint.geoPointForCurrentLocation(inBackground: { (PFGeoPoint, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                current!["myLocation"] = PFGeoPoint
                
                current?.saveInBackground(block: { (success, error) in
                    if let error = error{
                        print(error.localizedDescription);
                    } else {
                        print("it worked");
                    }
                })
            }
        })
        
        let query = PFQuery(className: "user");
        //query.whereKEy("family", equalTo: PFUser.current()?.username)
        query.findObjectsInBackground { (users, error) in
            print(users);
        }
    }
    ///
   
    ///
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // zooms into the users location
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true  // this line of code shows blue dot for user location i can also go to map view and toggle it on and off
            centerViewOnUserLocation()
            // updates user location to show when user is moving
            locationManager.startUpdatingLocation()
            
            
            
            break
        case .denied:
            // show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // show an alert
            break
        case .authorizedAlways:
            break
        }
    }



    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        guard let location = locations.last else { return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        
        // 5 instantiate annotation object to show pin on map
        let newPin = MKPointAnnotation()
        //removes the last pin
        mapView.removeAnnotation(newPin)
        // set region on the map
        mapView.setRegion(region, animated: true)
        
        // adds a new pin
        newPin.coordinate = location.coordinate
        newPin.title = "Current location"
        newPin.subtitle = "Las Vegas"
        mapView.addAnnotation(newPin)
    }
    
    let profileImage = PFUser.current()?["ProfilePic"] as? PFFileObject
    
    func mapView(_ mapView: MKMapView, viewFor newPin: MKAnnotation) -> MKAnnotationView? {
        guard !(newPin is MKUserLocation) else {
            let newPinView = MKPinAnnotationView(annotation: newPin, reuseIdentifier: "userLocation")
            newPinView.image = UIImage(named: "profileImage")
            return newPinView
        
        }
        return nil
    }
    //whenever the authorization changes it runs through the switch statement
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
