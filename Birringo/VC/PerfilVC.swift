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
    @IBOutlet weak var userEmailTextField: UITextField!
    var response : Response?
    var params : [String : Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        loadProfileData()
        perfilTableView.dataSource = self
        perfilTableView.delegate = self
        usernameTextField.text = nil
        userEmailTextField.text = nil
        self.title = ""
        self.navigationController?.tabBarItem.title = "Perfil"
    }
    
    private func setupColors(){
        tabBarController?.tabBar.backgroundColor = UIColor(named: "background_views")
        perfilView.backgroundColor = UIColor(named: "background_views")
        perfilTableView.backgroundColor = UIColor(named: "background_white")
        perfilTableView.corneRadius = 30
        perfilTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        userEmailTextField.backgroundColor = UIColor(named: "background_views")
       
    }
    
    func loadProfileData(){
        NetworkManager.shared.getUserProfile(apiToken: Session.shared.api_token!){
            response , errors in DispatchQueue.main.async{
                self.response = response
        
                if response?.msg == "Datos obtenidos" && response?.status == 1 {
                    self.loadProfileImage()
                    self.usernameTextField.text = response?.datos_perfil?.name ?? "Jonathan Miguel"
                    self.userEmailTextField.text = response?.datos_perfil?.email ?? "jonacedev@gmail.com"
                    
                } else if errors == .badData {
                    self.displayAlert(title: "Error", message: "Ha habido un error")
                    
                } else if errors == .errorConnection {
                    self.displayAlert(title: "Error", message: "El servidor no responde")
                    
                } else {
                    self.displayAlert(title: "Error", message: "Ha habido un error")
                }
            }
        }
    }
    
    func loadProfileImage(){
        NetworkManager.shared.getImageFrom(imageUrl: response?.datos_perfil?.imagen ?? ""){
            image in DispatchQueue.main.async {
                self.indicatorView.isHidden = true
                if let image = image {
                    self.userProfileImage.image = image
                    self.userProfileImage.layer.cornerRadius = self.userProfileImage.bounds.size.width / 2.0
                } else {
                    //Si el usuario del cual obtenemos los datos no tiene imagen de perfil en la base de datos se le asignara na por defecto.
                    self.userProfileImage.image = UIImage(named: "user_img")!
                }
            }
        }
    }
    
    //Funciones para cambiar la imagen de perfil del usuario.
    @IBAction func changePorfileImageTapped(_ sender: Any) {
        
        let ac = UIAlertController(title: "Añade una foto  de perfil", message: "Selecciona una imagen desde:", preferredStyle: .actionSheet)
        let cameraBtn = UIAlertAction(title: "Camera", style: .default) { (_)  in
            self.showImagePicker(selectedSource: .camera)
            print("Camera pressed")
        }
        let galleryBtn = UIAlertAction(title: "Galeria", style: .default) { (_)  in
            self.showImagePicker(selectedSource: .photoLibrary)
            print("Galeria seleccionada")
        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cameraBtn)
        ac.addAction(galleryBtn)
        ac.addAction(cancelBtn)
        self.present(ac, animated: true, completion: nil)
    }
    
    func showImagePicker(selectedSource: UIImagePickerController.SourceType){
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource) else {
            print("Seleccion no disponible")
            return
        }
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = selectedSource
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage{
            self.userProfileImage.image = selectedImage
            let imageStringData = convertImageToBase64(image: selectedImage)
            self.indicatorView.isHidden = false

            params = [
                "image" : imageStringData,
            ]
            
            NetworkManager.shared.uploadProfileImage(apiToken: Session.shared.api_token!, params: params){
                response, errors in DispatchQueue.main.async {
                    self.response = response
        
                    if response?.status == 1 && response?.msg == "Imagen guardada" {
                        //Recargar datos del perfil
                        self.loadProfileData()
                        
                    } else if errors == .badData {
                        self.displayAlert(title: "Error", message: "Ha habido un error")
                        
                    } else if errors == .errorConnection {
                        self.displayAlert(title: "Error", message: "El servidor no responde")
                        
                    } else if response?.status == 0 {
                        //Si hay algun fallo a la hora de subir la imagen nos devolvera el error en el response y se le mostrara al usuario mediante un alert
                        self.displayAlert(title: "Error", message: "\(response?.msg ?? "Se ha producido un error")")
                    }
                }
            }
        } else {
            self.displayAlert(title: "Error", message: "Ha habido un error")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Funcion para convertir imagen a base64 con el fin de enviarlo posteriormente al servidor donde se almacenara.
    func convertImageToBase64(image: UIImage) -> String {
        let imageData = image.jpegData(compressionQuality: 0.6)!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    //Table view functions
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
    
    // Funcion para instanciar alerts.
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

