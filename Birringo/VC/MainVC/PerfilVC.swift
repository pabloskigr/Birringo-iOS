//
//  PerfilVC.swift
//  Birringo
//
//  Created by APPS2T on 25/1/22.
//

import UIKit

class PerfilVC: UIViewController,  UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource {
    
    enum Opciones : Int {
        case ajustes = 0, favoritos, cerrarSesion
    }
    var ajustes : Opciones = .ajustes
    var favoritos : Opciones = .favoritos
    var cerrarSesion : Opciones = .cerrarSesion
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let storyboard2 = UIStoryboard(name: "Accesory", bundle: nil)
    
    @IBOutlet weak var perfilTableView: UITableView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet var perfilView: UIView!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var userBiographyTextView: UITextView!
    @IBOutlet weak var editProfileButton: UIButton!
    var response : Response?
    var params : [String : Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        loadProfileData()
        editProfileButton.isEnabled = false
        usernameTextField.text = nil
        userBiographyTextView.text = nil
        userProfileImage.image = nil
        perfilTableView.dataSource = self
        perfilTableView.delegate = self
        usernameTextField.text = ""
        self.title = ""
        self.navigationController?.tabBarItem.title = "Perfil"
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadProfileData), name: Notification.Name("reloadProfileData"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadProfileData()
    }
    
    @objc func reloadProfileData (notification: NSNotification){
        //Esta funcion sirve para recargar los datos del usaurio desde la vista de editar cuando el usaurio guarde los cambios.
        self.indicatorView.isHidden = false
        loadProfileData()
    }
    
    func loadProfileData(){
        NetworkManager.shared.getUserProfile(apiToken: Session.shared.api_token!){
            response , errors in DispatchQueue.main.async{
                self.response = response
        
                if response?.status == 1 {
                    self.loadProfileImage()
                    self.usernameTextField.text = response?.datos_perfil?.name?.capitalized ?? "Jonathan Miguel"
                    self.userBiographyTextView.text = response?.datos_perfil?.biografia ?? ""
                    
                } else if errors == .badData {
                    self.displayAlert(title: "Error", message: "Ha habido un error, vuelve a intentarlo mas tarde.")
                    
                } else if errors == .errorConnection {
                    self.displayAlert(title: "Error", message: "Ha habido un error, vuelve a intentarlo mas tarde.")
                    
                } else {
                    self.displayAlert(title: "Error", message: "Ha habido un error, vuelve a intentarlo mas tarde.")
                }
            }
        }
    }
    
    
    func loadProfileImage(){
        NetworkManager.shared.getImageFrom(imageUrl: response?.datos_perfil?.imagen ?? ""){
            image in DispatchQueue.main.async {
                self.indicatorView.isHidden = true
                self.editProfileButton.isEnabled = true
                
                if let image = image {
                    self.userProfileImage.image = image
                    self.userProfileImage.layer.cornerRadius = self.userProfileImage.bounds.size.width / 2.0
                } else {
                    //Si el usuario del cual obtenemos los datos no tiene imagen de perfil en la base de datos se le asignara una por defecto.
                    self.userProfileImage.image = UIImage(named: "user_img")!
                }
            }
        }
    }
    
    @IBAction func editProfileTapped(_ sender: Any) {
        
        if let detailModalView = storyboard?.instantiateViewController(identifier: "EditProfileVC") as? EditProfileVC {
            detailModalView.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            detailModalView.modalPresentationStyle = .overFullScreen
            if let datos = self.response {
                detailModalView.userResponse = datos
            }
            self.present(detailModalView, animated: true, completion: nil)
        }
    }
    
    //MARK: - Table view Functions:
    
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
       return "Opciones"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        perfilTableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath.row == ajustes.rawValue)  {
            let ajustesVC = storyboard2.instantiateViewController(identifier: "AjustesVC") as? AjustesVC
            ajustesVC?.usuario = response?.datos_perfil
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
    
    private func setupColors(){
        tabBarController?.tabBar.backgroundColor = UIColor(named: "background_views")
        perfilView.backgroundColor = UIColor(named: "background_views")
        perfilTableView.backgroundColor = UIColor(named: "background_white")
        perfilTableView.corneRadius = 30
        perfilTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        editProfileButton.layer.cornerRadius = 6
        userBiographyTextView.backgroundColor = UIColor(named: "background_views")
       
    }
    
    // Funcion para instanciar alerts.
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

