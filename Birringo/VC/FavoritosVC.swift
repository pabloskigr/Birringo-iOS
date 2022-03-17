//
//  FavoritosVC.swift
//  Birringo
//
//  Created by APPS2T on 26/1/22.
//

import UIKit

class FavoritosVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var favoritosTableView: UITableView!
    
    var response : Response?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        obtainFavBeers()
        self.title = ""
        self.navigationController?.tabBarItem.title = "Perfil"
        favoritosTableView.dataSource = self
        favoritosTableView.delegate = self
        
    }
    
    private func setupColors(){
        tabBarController?.tabBar.backgroundColor = UIColor(named: "background_views")
        favoritosTableView.backgroundColor = UIColor(named: "background_white")
        favoritosTableView.corneRadius = 30
        favoritosTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
       
    }
    
    func obtainFavBeers(){
        NetworkManager.shared.getFavsFromUser(apiToken: Session.shared.api_token!){
            response, errors in DispatchQueue.main.async {
                if response?.status == 1 {
                    self.response = response
                    self.favoritosTableView.reloadData()
                }
                
            }
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.beers?.count ?? 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "favoritosCellid", for: indexPath) as? FavoritosCell {
            cell.backgroundColor = UIColor(named: "background_white")
            cell.favoritosData = response?.beers?[indexPath.row]
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoritosTableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(identifier: "BeerDetailVC") as? BeerDetailVC {
            detailVC.beer = response?.beers?[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        
    }
    
    //MARK: - Eliminar favoritos pendiente de terminar API.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            MockData.favoritos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    

    
}
