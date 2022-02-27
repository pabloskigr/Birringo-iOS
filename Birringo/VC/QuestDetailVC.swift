//
//  QuestDetailVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 28/1/22.
//

import UIKit
import CoreLocation

class QuestDetailVC: UIViewController, CLLocationManagerDelegate {
    
    var questData : Quest?
    var locationManager = CLLocationManager()
    var barCordinates: CLLocation?
    var userCordinate: CLLocation?
    @IBOutlet var questView: UIView!
    @IBOutlet weak var questViewBox: UIView!
    @IBOutlet weak var questTitle: UILabel!
    @IBOutlet weak var questLocation: UILabel!
    @IBOutlet weak var questPoints: UILabel!
    @IBOutlet weak var questDistance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        getUserLocation()
     
        questTitle.text = questData?.titulo
        questLocation.text = String((questData?.pub?.calle) ?? "")
        questPoints.text = "Puntos: \(questData?.puntos ?? 0)"
    }
    
    func setupColors(){
        questView.backgroundColor = UIColor(named: "background_views")
        questViewBox.backgroundColor = UIColor(named: "background_white")
    }
    
    func getUserLocation(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManagerDidChangeAuthorization(locationManager)
        } else {
            //Notificar al usuario que tiene el gps desactivado
            displayAlert(title: "GPS", message: "El GPS esta desactivado")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            displayAlert(title: "Permisos restringidos", message: "Permisos de localización restingidos, no es posible obtener la distancia al bar.")
            break
        case .denied:
            displayAlert(title: "Permisos denegados", message: "Permisos de localización denegados, no es posible obtener la distancia al bar.")
            break
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            questDistance.text = "Distancia: \(obtainDistance())"
        @unknown default:
            break
        }
    }
    
    func obtainDistance() -> String {
        
        var distanceToReturn = ""
        
        if let latitudeDouble = locationManager.location?.coordinate.latitude, let longitudeDouble = locationManager.location?.coordinate.longitude {
            userCordinate = CLLocation(latitude: latitudeDouble, longitude: longitudeDouble)
            //Si no llegan coordenadas o son erroneas tratar error
            barCordinates = CLLocation(latitude: (questData?.pub?.latitud)!, longitude: (questData?.pub?.longitud)!)
            print(barCordinates!)
            var distance = userCordinate?.distance(from: barCordinates!) ?? 0
            
            if distance > 1000 {
                distance = distance / 1000
                distanceToReturn = "\(round(distance))km"
            } else {
                distanceToReturn = "\(round(distance))m"
            }
        }
        return distanceToReturn
    }
    
    
    @IBAction func ScannerButtonTapped(_ sender: Any) {
        if let qrVC = storyboard?.instantiateViewController(identifier: "QRVC") as? QRVC {
            qrVC.modalPresentationStyle = .fullScreen
            qrVC.modalTransitionStyle = .crossDissolve
        self.present(qrVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func MapsButtonTapped(_ sender: Any) {
        
        if let mapsVC = storyboard?.instantiateViewController(withIdentifier: "DetailMapVC") as? DetailMapVC {
            let latidud = questData?.pub?.latitud
            let longitud = questData?.pub?.longitud
            mapsVC.barName = questData?.pub?.titulo
            mapsVC.coordenadas = CLLocationCoordinate2DMake(latidud!, longitud!)
            navigationController?.pushViewController(mapsVC, animated: true)
        }
    }
    
    // Funcion para instanciar alerts.
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
