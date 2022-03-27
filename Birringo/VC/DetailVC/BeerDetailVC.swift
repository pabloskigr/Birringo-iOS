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
    var beerToAdd : [String : Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupColors()
        beerLocationsTableView.delegate = self
        beerLocationsTableView.dataSource = self
        getUserLocation()
        
        checkFav()
        beerImage.image = nil
        sortButton.setTitle("", for: .normal)
        beerName.text = beer?.titulo
        beerDescription.text = beer?.descripcion
        NetworkManager.shared.getImageFrom(imageUrl: beer?.imagen2 ?? ""){
            image in DispatchQueue.main.async {
                if let image = image {
                    self.beerImage.image = image
                } else {
                    //Si el usuario del cual obtenemos los datos no tiene imagen de perfil en la base de datos se le asignara na por defecto.
                    self.beerImage.image = UIImage(named: "Cervezas-la-Virgen")!
                }
            }
        }
      
    }

    
    func checkFav(){
        guard let favorita = beer?.isFav else{return}
        if favorita != 0  {
            favButton.isSelected = true
        } else {
            favButton.isSelected = false
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
            //Evitar null al pulsar en la celda
            break
        case .denied:
            print("Localizacion restringida para la app en ajustes")
            //Evitar null al pulsar en la celda
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
        return beer?.pubs?.count ?? 0
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
        if let mapsVC = storyboard?.instantiateViewController(withIdentifier: "DetailMapVC") as? DetailMapVC {
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
        //beer?.isFav?.toggle()
        beerToAdd = [
            "beerID" : beer?.id ?? -1
        ]
        
        if favButton.isSelected{
            //Lanzar peticion para añadir
            
            NetworkManager.shared.addBeerToFav(apiToken: Session.shared.api_token!, params: beerToAdd){
                response, error in DispatchQueue.main.async {
                    if response?.status == 1 {
                        self.displayAlert(title: "Favoritos", message: response?.msg ?? "")
                    } else if error == .badData {
                        self.displayAlert(title: "Error", message: "Ha ocurrido un error")
                        
                    } else if error == .errorConnection {
                        self.displayAlert(title: "Error", message: "Ha ocurrido un error")
                        
                    } else {
                        self.displayAlert(title: "Error", message: "Ha ocurrido un error")
                    }
                }
            }
        } else {
            //Lanzar peticion para eliminar
    
        }
         
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
    
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
