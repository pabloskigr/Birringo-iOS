//
//  PerfilVC.swift
//  Birringo
//
//  Created by APPS2T on 25/1/22.
//

import UIKit

class PerfilVC: UIViewController,  UITableViewDelegate, UITableViewDataSource {
   
    
   
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
        perfilTableView.corneRadius = 30
        perfilTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBarController?.tabBar.backgroundColor = UIColor(named: "background_views")
        perfilView.backgroundColor = UIColor(named: "background_views")
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MockData.datosPerfil.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "perfilCellId", for: indexPath) as? PerfilOpstionsCell {
            
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
    }
}

