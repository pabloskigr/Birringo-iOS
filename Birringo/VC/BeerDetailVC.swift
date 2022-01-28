//
//  BeerDetailVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 28/1/22.
//

import UIKit

class BeerDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var beer : beerData?
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerLocationsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beerLocationsTableView.delegate = self
        beerLocationsTableView.dataSource = self
        beerName.text = beer?.titulo
        beerDescription.text = beer?.description
        beerImage.image = beer?.image

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
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ubicaciones"
    }
    
    
    



}
