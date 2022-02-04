//
//  BeerDetailVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 28/1/22.
//

import UIKit
import CoreLocation

class BeerDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
   
    var beer : beerData?
    var locationManager = CLLocationManager()
    var barCordinates: CLLocation?
    var userCordinate: CLLocation?
    @IBOutlet var beerDetailView: UIView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerLocationsTableView: UITableView!
    @IBOutlet weak var favButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        beerLocationsTableView.delegate = self
        beerLocationsTableView.dataSource = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        beerName.text = beer?.titulo
        beerDescription.text = beer?.description
        beerImage.image = beer?.image
    }
    
    func setupColors(){
        beerDetailView.backgroundColor = UIColor(named: "background_views")
        beerLocationsTableView.backgroundColor = UIColor(named: "background_white")
        beerLocationsTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        beerLocationsTableView.corneRadius = 30
        beerLocationsTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beer!.location.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableCellid", for: indexPath) as! DetailCell
        
        userCordinate = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        barCordinates = CLLocation(latitude: (beer?.location[indexPath.row].latitud)!, longitude: (beer?.location[indexPath.row].longitud)!)
        beer?.location[indexPath.row].distance = userCordinate?.distance(from: barCordinates!)
        cell.bares = beer?.location[indexPath.row]
        cell.backgroundColor = UIColor(named: "background_white")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        beerLocationsTableView.deselectRow(at: indexPath, animated: true)
        if let mapsVC = storyboard?.instantiateViewController(withIdentifier: "MapsVC") as? MapsVC {
           
            mapsVC.barName = beer?.location[indexPath.row].title
            mapsVC.coordenadas = barCordinates?.coordinate
            locationManager.stopUpdatingLocation()
            navigationController?.pushViewController(mapsVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ubicaciones"
    }
    
    @IBAction func favTapped(_ sender: Any) {
        favButton.isSelected = !favButton.isSelected
        self.beer?.location.sort { $0.distance! < $1.distance! }
        beerLocationsTableView.reloadData()
    }
        //si esta en modo default al pulsarlo añadir a favoritos, si esta en modo pulsado al pulsarlo quitar de favoritos
    }
