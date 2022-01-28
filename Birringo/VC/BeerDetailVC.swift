//
//  BeerDetailVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 28/1/22.
//

import UIKit

class BeerDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerLocationsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beerLocationsTableView.delegate = self
        beerLocationsTableView.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return numero de bares asociados a la cerveza
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //celula personalizada donde se pintaran los datos
        return UITableViewCell()
    }
    
    
    



}
