//
//  AjustesVC.swift
//  Birringo
//
//  Created by pabloGarcia on 7/2/22.
//

import UIKit

class AjustesVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
    enum Opciones : Int {
        case terminosLegales = 0, politica, tutorial
    }
    
    let opciones : [AjustesData] = [
        AjustesData(title: "Terminos y condiciones"),
        AjustesData(title: "Politica de privacidad"),
        AjustesData(title: "Tutorial")
    ]
    
    var politica : Opciones = .politica
    var tutorial : Opciones = .tutorial
    var terminosLegales : Opciones = .terminosLegales
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let storyboard2 = UIStoryboard(name: "Accesory", bundle: nil)
    
    @IBOutlet var ajustesView: UIView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var ajustesTableView: UITableView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UITextField!
    var response : Response?
    var params : [String : Any]?
    var usuario : UserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        ajustesTableView.delegate = self
        ajustesTableView.dataSource = self
        self.title = ""
        self.navigationController?.tabBarItem.title = "Ajustes"
        
        loadUserData()
    }
    
    func loadUserData(){
        userNameLabel.text = usuario?.name ?? ""
        userImage.layer.cornerRadius = userImage.bounds.size.width / 2.0
        
        NetworkManager.shared.getImageFrom(imageUrl: usuario?.imagen ?? "") {
            image in DispatchQueue.main.async {
                
                if let image = image {
                    self.userImage.image = image
                } else {
                    self.userImage.image = UIImage(named: "user_img")
                }
               
            }
        }
    }
    
    private func setupColors(){
        ajustesView.backgroundColor = UIColor(named: "background_views")
        ajustesTableView.backgroundColor = UIColor(named: "background_white")
        ajustesTableView.corneRadius = 30
        ajustesTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opciones.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ajustes"
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AjustesCell", for: indexPath) as? AjustesCell {
            cell.backgroundColor = UIColor(named: "background_white")
            cell.ajustesData = opciones[indexPath.row]
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        ajustesTableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath.row == politica.rawValue)  {
            if let politicasVC = storyboard2.instantiateViewController(identifier: "PoliticasVC") as? PoliticasVC {
                present(politicasVC, animated: true, completion: nil)
            }
        }
        
        if (indexPath.row == tutorial.rawValue)  {
            if let tutorialVC = mainStoryboard.instantiateViewController(identifier: "OnboardingVC") as? OnboardingVC {
                present(tutorialVC, animated: true, completion: nil)
            }
        }
        
        if (indexPath.row == terminosLegales.rawValue)  {
            if let terminosVC = storyboard2.instantiateViewController(identifier: "TerminosVC") as? TerminosVC {
                present(terminosVC, animated: true, completion: nil)
            }

        }
    }
    
}
