//
//  AjustesVC.swift
//  Birringo
//
//  Created by pabloGarcia on 7/2/22.
//

import UIKit

class AjustesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum Opciones : Int {
        case politicas = 0, tutorial, terminosLegales
    }
    var politicas : Opciones = .politicas
    var tutorial : Opciones = .tutorial
    var terminosLegales : Opciones = .terminosLegales
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let storyboard2 = UIStoryboard(name: "Accesory", bundle: nil)
    
    @IBOutlet var ajustesView: UIView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var ajustesTableView: UITableView!
    var response : Response?
    var params : [String : Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupColors()
        indicatorView.isHidden = true
        self.title = ""
        ajustesTableView.dataSource = self
        ajustesTableView.delegate = self
        self.title = ""
        self.navigationController?.tabBarItem.title = "Ajustes"
    }
    
//    private func setupColors(){
//        ajustesView.backgroundColor = UIColor(named: "background_views")
//        ajustesTableView.backgroundColor = UIColor(named: "background_white")
//        ajustesTableView.corneRadius = 30
//        ajustesTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//
//    }
    func numberOfSections(in tutorialTableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MockData.ajustes.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AjustesVC", for: indexPath) as? AjustesCell {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        ajustesTableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath.row == politicas.rawValue)  {
            let PoliticasVC = storyboard2.instantiateViewController(identifier: "PoliticasVC") as? PoliticasVC
            navigationController?.pushViewController(PoliticasVC!, animated: true)
        }
        
        if (indexPath.row == tutorial.rawValue)  {
            let  OnboardingVC = mainStoryboard.instantiateViewController(identifier: "OnboardingVC") as? OnboardingVC
            navigationController?.pushViewController(OnboardingVC!, animated: true)
        }
        
        if (indexPath.row == terminosLegales.rawValue)  {
            let TerminosVC = storyboard2.instantiateViewController(identifier: "TerminosVC") as? TerminosVC
            navigationController?.pushViewController(TerminosVC!, animated: true)

        }
    }
    

}
