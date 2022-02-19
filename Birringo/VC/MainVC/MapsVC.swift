//
//  MapsVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 30/1/22.
//

import UIKit
import MapKit
import CoreLocation

class MapsVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var barLocatonButton: UIButton!
    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    var coordenadas: CLLocationCoordinate2D?
    var userCordinate: CLLocationCoordinate2D?
    var barName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserLocation()
        barLocatonButton.setTitle("", for: .normal)
        map.delegate = self
        map.showsUserLocation = true
        
        if let coordenadas = coordenadas {
            barLocatonButton.isHidden = false
            mapThis(destinationCord: coordenadas)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordenadas
            annotation.title = barName ?? ""
            map.addAnnotation(annotation)
    
            let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            map.setRegion(region, animated: true)
        } else {
            barLocatonButton.isHidden = true
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations)
    }
    
    func getUserLocation(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManagerDidChangeAuthorization(locationManager)
        } else {
            //Notificar al usuario que tiene el gps desactivado
            print("GPS desactivado")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("Notificar al usuario. Localizacion restringida por configuracion paternal")
            break
        case .denied:
            print("Localizacion restringida para la app en ajustes")
            break
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            userCordinate = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        @unknown default:
            break
        }
    }
    
 
    @IBAction func userLocationTapped(_ sender: Any) {
        self.map.setCenter(self.map.userLocation.coordinate, animated: true)
        let region = MKCoordinateRegion(center: map.userLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        map.setRegion(region, animated: true)
    }
    
    @IBAction func barLocationTapped(_ sender: Any) {
        let region = MKCoordinateRegion(center: coordenadas!, latitudinalMeters: 500, longitudinalMeters: 500)
        map.setRegion(region, animated: true)
    }
    
    func mapThis(destinationCord: CLLocationCoordinate2D){
        
        let userPlaceMark = MKPlacemark(coordinate: userCordinate!)
        let destPlacemark = MKPlacemark(coordinate: destinationCord)
        let userItem = MKMapItem(placemark: userPlaceMark)
        let destItem = MKMapItem(placemark: destPlacemark)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = userItem
        destinationRequest.destination = destItem
        destinationRequest.transportType = .walking
        destinationRequest.requestsAlternateRoutes = true
        
        let direction = MKDirections(request: destinationRequest)
        direction.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Algo ha ido mal")
                }
             return
                
            }
            let route = response.routes[0]
            self.map.addOverlay(route.polyline)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .orange
        return render
    }
    
}
