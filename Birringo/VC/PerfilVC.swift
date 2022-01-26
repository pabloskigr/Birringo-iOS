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
        perfilTableView.dataSource = self
        perfilTableView.delegate = self
        
    }
    private func setupColors(){
        perfilTableView.backgroundColor = UIColor(named: "background_views")
        tabBarController?.tabBar.backgroundColor = UIColor(named: "background_views")
       /* perfilView.backgroundColor = UIColor(named: "background_views")*/
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
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.systemGray3
            cell.selectedBackgroundView = bgColorView
            cell.backgroundColor = UIColor(named: "background_views")
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

