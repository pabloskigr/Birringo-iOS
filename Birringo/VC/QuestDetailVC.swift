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
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        questTitle.text = questData?.title
        questLocation.text = String((questData?.location[0].title) ?? "")
        questPoints.text = "Puntos: \(questData?.points ?? 0)"
        setupColors()
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
