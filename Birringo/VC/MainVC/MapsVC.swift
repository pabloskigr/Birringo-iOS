//
//  MapsVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 30/1/22.
//

import UIKit
import MapKit
import CoreLocation

class MapsVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate {

    @IBOutlet var mapsView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pubsLocationButton: UIButton!
    @IBOutlet weak var userLocationButton: UIButton!
    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    var coordenadas: CLLocationCoordinate2D?
    var userCordinate: CLLocationCoordinate2D?
    let madridLocation = CLLocationCoordinate2DMake(40.4167, -3.70325)
    var barName: String?
    var response : Response?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpColors()
        checkGpsEnabled()
        self.navigationController?.navigationBar.isHidden = true
        map.delegate = self
        searchBar.delegate = self
        
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
            displayAlert(title: "Permisos restringidos", message: "Permisos de localizacion restingidos, puedes cambiarlos desde ajustes.")
            getPubsMarkers()
            break
        case .denied:
            userLocationButton.isHidden = true
            displayAlert(title: "Permisos denegados", message: "Permisos de localizacion restingidos, puedes cambiarlos desde ajustes.")
            getPubsMarkers()
            break
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            map.showsUserLocation = true
            userCordinate = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
            getPubsMarkers()
        @unknown default:
            break
        }
    }
    
    func getPubsMarkers(){
        //Obtener bares de api y mostrar los marcadores
        
        NetworkManager.shared.getPubs(apiToken: Session.shared.api_token!){
            response, errors in DispatchQueue.main.async {
                self.response = response
                
                if response?.status == 1 {
                    
                    if let pubsData = response?.pubs {
                        for pubs in pubsData {

                            let point = MKPointAnnotation()
                            let pointlatitude = pubs.latitud
                            let pointlongitude = pubs.longitud
                            point.title = pubs.titulo
                            point.coordinate = CLLocationCoordinate2DMake(pointlatitude! ,pointlongitude!)
                            self.map.addAnnotation(point)
                        }

                        let region = MKCoordinateRegion(center: self.madridLocation, latitudinalMeters: 8000, longitudinalMeters: 8000)
                        self.map.setRegion(region, animated: true)
                        
                    } else {
                        self.displayAlert(title: "Error", message: "No se han obtenido bares para mostrar.")
                        self.pubsLocationButton.isHidden = true
                    }
                    
                } else if errors == .badData {
                    self.displayAlert(title: "Error", message: "Ha habido un error, vuelve a intentarlo mas tarde.")
                    self.pubsLocationButton.isHidden = true
                    
                } else if errors == .errorConnection {
                    self.displayAlert(title: "Error", message: "Ha habido un error, vuelve a intentarlo mas tarde.")
                    self.pubsLocationButton.isHidden = true
                    
                } else if response?.status == 0 {
                    //Si hay algun fallo nos devolvera el error en el response y se le mostrara al usuario mediante un alert
                    self.displayAlert(title: "Error", message: "\(response?.msg ?? "Se ha producido un error")")
                    self.pubsLocationButton.isHidden = true
                }
            }
        }
        
       
    }
    
    // Funciones del buscador de pubs en nuestra base de datos.
    
    //Search bar functions
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        //searchView.isHidden = false
        //self.titleToReturn = "Ultimas novedades"
        //searchBeers(input: "")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //searchView.isHidden = true
        ///Obtener los marcadores por defecto de Madrid
        getPubsMarkers()
        //self.titleToReturn = "Ultimas novedades"
        //self.searchTableView.reloadData()
        self.isEditing = false
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        response = nil
        //self.titleToReturn = "Resultados"
        searchPubs(input: searchText.uppercased())
    }
    
    func searchPubs(input : String){
        //Falta indicator View
        
        NetworkManager.shared.getPubsByName(apiToken: Session.shared.api_token!, input: input){
            response, errors in DispatchQueue.main.async {
       
                //self.indicatorView.isHidden = true
                if response?.status == 1 {
                    self.map.removeAnnotations(self.map.annotations)
                    self.response = response
                    
                    if let pubsData = response?.pubs {
                        for pubs in pubsData {

                            let point = MKPointAnnotation()
                            let pointlatitude = pubs.latitud
                            let pointlongitude = pubs.longitud
                            point.title = pubs.titulo
                            point.coordinate = CLLocationCoordinate2DMake(pointlatitude! ,pointlongitude!)
                            self.map.addAnnotation(point)
                        }

                        let region = MKCoordinateRegion(center: self.madridLocation, latitudinalMeters: 6000, longitudinalMeters: 6000)
                        self.map.setRegion(region, animated: true)
                        
                    } else {
                        self.displayAlert(title: "Error", message: "No se han obtenido bares para mostrar.")
                        self.pubsLocationButton.isHidden = true
                    }
                    
                } else if errors == .badData {
                    self.displayAlert(title: "Error", message: "Ha habido un error")
                    self.pubsLocationButton.isHidden = true
                    
                } else if errors == .errorConnection {
                    self.displayAlert(title: "Error", message: "El servidor no responde")
                    self.pubsLocationButton.isHidden = true
                    
                } else if response?.status == 0 {
                    //Si hay algun fallo nos devolvera el error en el response y se le mostrara al usuario mediante un alert
                    self.displayAlert(title: "Error", message: "\(response?.msg ?? "Se ha producido un error")")
                    self.pubsLocationButton.isHidden = true
                }
            }
        }
        
    }

    
  
    @IBAction func userLocationTapped(_ sender: Any) {
        let region = MKCoordinateRegion(center: userCordinate!, latitudinalMeters: 500, longitudinalMeters: 500)
        map.setRegion(region, animated: true)
    }
    
    @IBAction func pubsLocationTapped(_ sender: Any) {
        let region = MKCoordinateRegion(center: madridLocation, latitudinalMeters: 8000, longitudinalMeters: 8000)
        map.setRegion(region, animated: true)
    }
    
    func setUpColors(){
        mapsView.backgroundColor = UIColor(named: "background_views")
        searchBar.barTintColor = UIColor(named: "background_views")
    }
    
    // Funcion para instanciar alerts.
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
