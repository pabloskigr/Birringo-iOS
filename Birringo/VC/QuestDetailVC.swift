//
//  QuestDetailVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 28/1/22.
//

import UIKit
import CoreLocation

class QuestDetailVC: UIViewController, CLLocationManagerDelegate {
    
    var questData : QuestData?
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
        
        
        questTitle.text = questData?.title
        questLocation.text = String((questData?.location[0].title) ?? "")
        questPoints.text = "Puntos: \(questData?.points ?? 0)"
    }
    
    func setupColors(){
        questView.backgroundColor = UIColor(named: "background_views")
        questViewBox.backgroundColor = UIColor(named: "background_white")
        questDistance.text = "Distancia: \(obtainDistance())"
    }
    
    func obtainDistance() -> String{
        
        userCordinate = CLLocation(latitude:(locationManager.location?.coordinate.latitude)!,longitude:(locationManager.location?.coordinate.longitude)!)
        barCordinates = CLLocation(latitude: (questData?.location[0].latitud)!, longitude: (questData?.location[0].longitud)!)
        var distance = userCordinate?.distance(from: barCordinates!) ?? 0
        
        if distance > 1000 {
            distance = distance / 1000
            return "\(round(distance))km"
        } else {
            return "\(round(distance))m"
        }
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
            userCordinate = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
            print("Permisos OK")
        @unknown default:
            break
        }
    }
    

    @IBAction func ScannerButtonTapped(_ sender: Any) {
        if let qrVC = storyboard?.instantiateViewController(identifier: "QRVC") as? QRVC {
            qrVC.modalPresentationStyle = .fullScreen
            qrVC.modalTransitionStyle = .crossDissolve
        self.present(qrVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func MapsButtonTapped(_ sender: Any) {
        
        if let mapsVC = storyboard?.instantiateViewController(withIdentifier: "MapsVC") as? MapsVC {
            let latidud = questData?.location[0].latitud
            let longitud = questData?.location[0].longitud
            mapsVC.barName = questData?.location[0].title
            mapsVC.coordenadas = CLLocationCoordinate2DMake(latidud!, longitud!)
            navigationController?.pushViewController(mapsVC, animated: true)
        }
    }
    
}
