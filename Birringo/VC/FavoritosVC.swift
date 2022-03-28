//
//  FavoritosVC.swift
//  Birringo
//
//  Created by APPS2T on 26/1/22.
//

import UIKit
import SkeletonView

class FavoritosVC: UIViewController, UITableViewDelegate, SkeletonTableViewDataSource{
    
    @IBOutlet weak var favoritosTableView: UITableView!
    @IBOutlet var favoritosView: UIView!
    var response : Response?
    let refreshControl = UIRefreshControl()
    //var userResponse : Response?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        obtainFavBeers()
        self.title = ""
        self.navigationController?.tabBarItem.title = "Perfil"
        favoritosTableView.dataSource = self
        favoritosTableView.delegate = self
        favoritosTableView.addSubview(refreshControl)
        loadSkeletoniew()
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
       obtainFavBeers()
    }
    
    func loadSkeletoniew(){
        favoritosTableView.isSkeletonable = true
        favoritosTableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .silver), animation: nil, transition: .crossDissolve(0.25))
    }

    
    func obtainFavBeers(){
        NetworkManager.shared.getFavsFromUser(apiToken: Session.shared.api_token!){
            response, errors in DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                
                if response?.status == 1 {
                    self.response = response
                    self.view.hideSkeleton(reloadDataAfter: true)
                    self.favoritosTableView.stopSkeletonAnimation()
                    self.favoritosTableView.reloadData()
                    
                } else if response?.status == 0 {
                    self.displayAlert(title: "Error", message: "Ha habido un error, vuelve a intentarlo mas tarde.")
                    
                } else {
                    self.displayAlert(title: "Error", message: "Ha habido un error, vuelve a intentarlo mas tarde.")
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
    
    //Skeleton function table view
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "favoritosCellid"
    }
    
    //MARK: - Eliminar favoritos pendiente de terminar API.
    /*func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            MockData.favoritos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }*/
    
    func errorConnectionAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action) in self.dismiss(animated: true, completion: nil) }))
        //Si hay error de conexion se mostrara este alert y a la vez se cerrara la vista modal de editar.
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupColors(){
        tabBarController?.tabBar.backgroundColor = UIColor(named: "background_views")
        favoritosTableView.backgroundColor = UIColor(named: "background_white")
        favoritosView.backgroundColor = UIColor(named: "background_white")
        favoritosTableView.corneRadius = 30
        favoritosTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
       
    }
    
    // Funcion para instanciar alerts.
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
