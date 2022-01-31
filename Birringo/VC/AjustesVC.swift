//
//  AjustesVC.swift
//  Birringo
//
//  Created by pabloGarcia on 29/1/22.
//

import UIKit

class AjustesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var ajustesTableView: UITableView!
    

    @IBOutlet var ajustesView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        self.title = ""
        self.navigationController?.tabBarItem.title = "Ajustes"
        ajustesTableView.dataSource = self
        ajustesTableView.delegate = self
        
    }
    private func setupColors(){
        ajustesTableView.corneRadius = 30
        ajustesTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBarController?.tabBar.backgroundColor = UIColor(named: "background_views")
        ajustesView.backgroundColor = UIColor(named: "background_views")
        ajustesTableView.backgroundColor = UIColor(named: "background_white")
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MockData.ajustes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ajustesCellid", for: indexPath) as? AjustesCell {
            cell.backgroundColor = UIColor(named: "background_white")
            cell.ajustesData = MockData.ajustes[indexPath.row]
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "Ajustes"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ajustesTableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath.row == 1)  {
            let storyboard2 = UIStoryboard(name: "Accesory", bundle: nil)
            let terminosLegalesVC = storyboard2.instantiateViewController(identifier: "TerminosLegalesVC") as? TerminosLegalesVC
            navigationController?.pushViewController(terminosLegalesVC!, animated: true)
            //present(registerVC!, animated: true, completion: nil)

            
    
        }
    }

}
