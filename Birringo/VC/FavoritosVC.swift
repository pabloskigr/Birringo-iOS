//
//  FavoritosVC.swift
//  Birringo
//
//  Created by APPS2T on 26/1/22.
//

import UIKit

class FavoritosVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var favoritosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        self.title = ""
        self.navigationController?.tabBarItem.title = "Perfil"
        favoritosTableView.dataSource = self
        favoritosTableView.delegate = self
        
    }
    
    private func setupColors(){
        favoritosTableView.corneRadius = 30
        favoritosTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBarController?.tabBar.backgroundColor = UIColor(named: "background_views")
        favoritosTableView.backgroundColor = UIColor(named: "background_white")
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MockData.favoritos.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "favoritosCellid", for: indexPath) as? FavoritosCell {
            cell.backgroundColor = UIColor(named: "background_white")
            cell.favoritosData = MockData.favoritos[indexPath.row]
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoritosTableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            MockData.favoritos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
        }
    }
    

    
}
