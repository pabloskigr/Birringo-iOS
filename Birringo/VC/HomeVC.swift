//
//  HomeVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 24/1/22.
//

import UIKit

class HomeVC: UIViewController, UITableViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var home_tableView: UITableView!
    var arrayPrueba = ["Heineken", "Casaamigos", "Fireball", "KWAK"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        home_tableView.dataSource = self
        home_tableView.delegate = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPrueba.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "homeCellid", for: indexPath) as? AppetizerCell {
            
            cell.appetizer = MockData.shared.appetizers[indexPath.row]
            return cell
            
        } else {return UITableViewCell()}
    }

}
