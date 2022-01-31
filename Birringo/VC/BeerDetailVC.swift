//
//  BeerDetailVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 28/1/22.
//

import UIKit
import CoreLocation

class BeerDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var beer : beerData?
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
        cell.bares = beer?.location[indexPath.row]
        cell.backgroundColor = UIColor(named: "background_white")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        beerLocationsTableView.deselectRow(at: indexPath, animated: true)
        if let mapsVC = storyboard?.instantiateViewController(withIdentifier: "MapsVC") as? MapsVC {
           
            let latidud = beer?.location[indexPath.row].latitud
            let longitud = beer?.location[indexPath.row].longitud
            mapsVC.barName = beer?.location[indexPath.row].title
            mapsVC.coordenadas = CLLocationCoordinate2DMake(latidud!, longitud!)
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
    }
    
