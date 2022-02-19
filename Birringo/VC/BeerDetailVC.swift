//
//  BeerDetailVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 28/1/22.
//

import UIKit
import CoreLocation

class BeerDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
   
    var locationManager = CLLocationManager()
    var beer : Beer?
    var barCordinates: CLLocation?
    var userCordinate: CLLocation?
    @IBOutlet var beerDetailView: UIView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerLocationsTableView: UITableView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        beerLocationsTableView.delegate = self
        beerLocationsTableView.dataSource = self
        getUserLocation()
        
        sortButton.setTitle("", for: .normal)
        beerName.text = beer?.titulo
        beerDescription.text = beer?.descripcion
        NetworkManager.shared.getImageFrom(imageUrl: beer?.imagen2 ?? ""){
            image in DispatchQueue.main.async {
                //self.indicatorView.isHidden = true
                if let image = image {
                    self.beerImage.image = image
                } else {
                    //Si el usuario del cual obtenemos los datos no tiene imagen de perfil en la base de datos se le asignara na por defecto.
                    self.beerImage.image = UIImage(named: "Cervezas-la-Virgen")!
                }
            }
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
            beerLocationsTableView.reloadData()
            print("Permisos OK")
        @unknown default:
            break
        }
    }
    
    func setupColors(){
        beerDetailView.backgroundColor = UIColor(named: "background_views")
        beerLocationsTableView.backgroundColor = UIColor(named: "background_white")
        beerLocationsTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        beerLocationsTableView.corneRadius = 30
        beerLocationsTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beer!.pubs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableCellid", for: indexPath) as! BeerPubsCell
        //añadir distancia a la cerveza
        barCordinates = CLLocation(latitude: (beer?.pubs![indexPath.row].latitud)!, longitude: (beer?.pubs![indexPath.row].longitud)!)
        beer?.pubs![indexPath.row].distance = userCordinate?.distance(from: barCordinates!) ?? 0
        cell.bares = beer?.pubs![indexPath.row]
        cell.backgroundColor = UIColor(named: "background_white")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        beerLocationsTableView.deselectRow(at: indexPath, animated: true)
        if let mapsVC = storyboard?.instantiateViewController(withIdentifier: "MapsVC") as? MapsVC {
            mapsVC.barName = beer?.pubs![indexPath.row].titulo
            mapsVC.coordenadas = barCordinates?.coordinate
            navigationController?.pushViewController(mapsVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ubicaciones"
    }
    
    @IBAction func favTapped(_ sender: Any) {
        favButton.isSelected = !favButton.isSelected
    }
        //si esta en modo default al pulsarlo añadir a favoritos, si esta en modo pulsado al pulsarlo quitar de favoritos
    @IBAction func sortButtonTapped(_ sender: Any) {
        sortButton.isSelected = !sortButton.isSelected
        if sortButton.isSelected == true {
            self.beer?.pubs!.sort { $0.distance! < $1.distance! }
            beerLocationsTableView.reloadData()
        } else {
            self.beer?.pubs!.sort { $0.distance! > $1.distance! }
            beerLocationsTableView.reloadData()
        }
        
    }
}
