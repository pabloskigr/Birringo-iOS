//
//  FavoritosVC.swift
//  Birringo
//
//  Created by APPS2T on 26/1/22.
//

import UIKit
import Network

class FavoritosVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var favoritosTableView: UITableView!
    
    @IBOutlet weak var indicatorView: UIView!
    
    var response : Response?
    var userResponse : Response?
    let networkMonitor = NWPathMonitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        obtainFavBeers()
        indicatorView.isHidden = true
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
    func checkInternetConnection(){
        networkMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    if let _ = self.userResponse {
                        self.networkMonitor.cancel()
                    } else {
                        self.errorConnectionAlert(title: "Error", message: "No se han podido cargar los datos, intentalo mas tarde.")
                        self.networkMonitor.cancel()
                    }
                }

            } else {
                DispatchQueue.main.async {
                    self.noConnection()
                    self.networkMonitor.cancel()
                }
            }
        }
        let queue = DispatchQueue.global(qos: .background)
            networkMonitor.start(queue: queue)
    }
    func noConnection(){
            indicatorView.isHidden = false
            errorConnectionAlert(title: "Error de conexion", message: "No se han podido cargar los datos, intentalo mas tarde.")
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
    
    func errorConnectionAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action) in self.dismiss(animated: true, completion: nil) }))
        //Si hay error de conexion se mostrara este alert y a la vez se cerrara la vista modal de editar.
        self.present(alert, animated: true, completion: nil)
    }
    

    
}
