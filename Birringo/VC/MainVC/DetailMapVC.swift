//
//  DetailMapVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 25/2/22.
//

import UIKit
import MapKit
import CoreLocation

class DetailMapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var userLocationButton: UIButton!
    @IBOutlet weak var barLocatonButton: UIButton!
    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    var coordenadas: CLLocationCoordinate2D?
    var userCordinate: CLLocationCoordinate2D?
    var barName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkGpsEnabled()
        barLocatonButton.setTitle("", for: .normal)
        map.delegate = self
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations)
    }
    
    func checkGpsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManagerDidChangeAuthorization(locationManager)
        } else {
            displayAlert(title: "GPS", message: "El GPS esta desactivado")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            userLocationButton.isHidden = true
            displayAlert(title: "Permisos restringidos", message: "Permisos de localización restringidos, no es posible trazar una ruta.")
            loadOnlyPubLocation()
            break
        case .denied:
            userLocationButton.isHidden = true
            displayAlert(title: "Permisos denegados", message: "Permisos de localización denegados, no es posible trazar una ruta.")
            loadOnlyPubLocation()
            break
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            map.showsUserLocation = true
            getRouteToPub()
                
        @unknown default:
            break
        }
    }
    
    func getRouteToPub(){
        
        //Si tenemos las coordenadas del pub obtenemos las del usuario asegurandos que no son nulas y trazamos la ruta.
        if let coordenadas = coordenadas {
            
            if let latitudeDouble = locationManager.location?.coordinate.latitude, let longitudeDouble = locationManager.location?.coordinate.longitude {
                userCordinate = CLLocationCoordinate2D(latitude: latitudeDouble, longitude: longitudeDouble)
                
                mapThis(destinationCord: coordenadas) //Funcion para trazar la ruta
                barLocatonButton.isHidden = false
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordenadas
                annotation.title = barName ?? ""
                map.addAnnotation(annotation)
                let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                map.setRegion(region, animated: true)
            } else {
                //Si las coordenadas del usuario son nulas mostraremos un error al usuario
                userLocationButton.isHidden = true
                displayAlert(title: "Error", message: "Ha habido un error, intentalo mas tarde.")
            }
        } else {
            //Si las coordenadas del pub son nulas mostraremos un error al usuario y no se cargara nada.
            userLocationButton.isHidden = true
            displayAlert(title: "Error", message: "Ha habido un error, intentalo mas tarde.")
        }
    }
    
    func loadOnlyPubLocation(){
        //Marcador del pub
        
        if let coordenadas = coordenadas {
            //Mostrar coordenadas del bar en un marcador
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: coordenadas.latitude, longitude: coordenadas.longitude)
            map.addAnnotation(annotation)
            let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            map.setRegion(region, animated: true)
            
        } else {
            //Si las coordenadas del bar son nulas mostraremos un error al usuario.
            userLocationButton.isHidden = true
            displayAlert(title: "Error", message: "Ha habido un error, intentalo mas tarde.")
        }
    }
    
    func getUserLocation(){
        
        if let latitudeDouble = locationManager.location?.coordinate.latitude, let longitudeDouble = locationManager.location?.coordinate.longitude {
            //Si las coordenadas del usuario no son nulas las asiganmos a la variable userCoordinates
            userCordinate = CLLocationCoordinate2D(latitude: latitudeDouble, longitude: longitudeDouble)
        } else {
            //Si las coordenadas del usuario son nulas mostraremos un error al usuario
            userLocationButton.isHidden = true
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
    
    // Funcion para instanciar alerts.
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
