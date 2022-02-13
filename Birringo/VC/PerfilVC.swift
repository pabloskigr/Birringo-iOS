//
//  PerfilVC.swift
//  Birringo
//
//  Created by APPS2T on 25/1/22.
//

import UIKit

class PerfilVC: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    enum Opciones : Int {
        case ajustes = 0, favoritos, cerrarSesion
    }
    var ajustes : Opciones = .ajustes
    var favoritos : Opciones = .favoritos
    var cerrarSesion : Opciones = .cerrarSesion
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let storyboard2 = UIStoryboard(name: "Accesory", bundle: nil)
    @IBOutlet weak var perfilTableView: UITableView!
    @IBOutlet var perfilView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        self.title = ""
        self.navigationController?.tabBarItem.title = "Perfil"
        perfilTableView.dataSource = self
        perfilTableView.delegate = self
        
    }
    private func setupColors(){
        tabBarController?.tabBar.backgroundColor = UIColor(named: "background_views")
        perfilView.backgroundColor = UIColor(named: "background_views")
        perfilTableView.backgroundColor = UIColor(named: "background_white")
        perfilTableView.corneRadius = 30
        perfilTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MockData.datosPerfil.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "perfilCellId", for: indexPath) as? PerfilOpstionsCell {
            cell.backgroundColor = UIColor(named: "background_white")
            cell.perfilData = MockData.datosPerfil[indexPath.row]
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "Ajustes"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        perfilTableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath.row == ajustes.rawValue)  {
            let ajustesVC = storyboard2.instantiateViewController(identifier: "AjustesVC") as? AjustesVC
            navigationController?.pushViewController(ajustesVC!, animated: true)
        }
        
        if (indexPath.row == favoritos.rawValue)  {
            let favoritosVC = storyboard2.instantiateViewController(identifier: "FavoritosVC") as? FavoritosVC
            navigationController?.pushViewController(favoritosVC!, animated: true)
        }
        
        if (indexPath.row == cerrarSesion.rawValue)  {
            UserDefaults.standard.removeObject(forKey: "api_token")
            if let loginVC = mainStoryboard.instantiateViewController(identifier: "LoginVC") as? LoginVC {
                loginVC.modalPresentationStyle = .fullScreen
                loginVC.modalTransitionStyle = .crossDissolve
            self.present(loginVC, animated: true, completion: nil)
            }

        }
    }
}

