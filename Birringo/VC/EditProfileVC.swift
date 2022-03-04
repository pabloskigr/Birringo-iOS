//
//  EditProfileVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 4/3/22.
//

import UIKit
import Photos

class EditProfileVC: UIViewController {
    
    @IBOutlet var profileView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var biographyTextView: UITextView!
    @IBOutlet weak var telefonoTextField: UITextField!
    
    var userResponse : Response?
    var response : Response?
    var params : [String : Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserData()

    }
    
    func loadUserData(){
        
        if userResponse?.datos_perfil?.telefono == 0 {
            telefonoTextField.text = ""
            telefonoTextField.placeholder = "Telefono (Opcional)"
        } else {
            telefonoTextField.text = ""
            telefonoTextField.placeholder = "Telefono (Opcional)"
        }
        
        userTextField.text = userResponse?.datos_perfil?.name
        emailTextField.text = userResponse?.datos_perfil?.email
        
       // biographyTextView.text = userResponse?.datos_perfil.biografia
        
        NetworkManager.shared.getImageFrom(imageUrl: (userResponse?.datos_perfil?.imagen)!){
            image in DispatchQueue.main.async {
    
                if let image = image {
                    self.userImage.image = image
                    self.userImage.layer.cornerRadius = self.userImage.bounds.size.width / 2.0
                } else {
                    //Si el usuario no tiene imagen de perfil, se le asignara una por defecto.
                    self.userImage.image = UIImage(named: "user_img")!
                }
            }
        }
    }
    
   
    
    @IBAction func saveChangesTapped(_ sender: Any) {
        
        params = [
            "name" : userTextField.text ?? "",
            "email"  : emailTextField.text ?? "" ,
            "telefono" : Int(telefonoTextField.text ?? "") ?? 0,
           // "biografia" : biographyTextView.text ?? ""
        ]
        
        NetworkManager.shared.editUserData(apiToken: Session.shared.api_token!, params: params){
            response, errors in DispatchQueue.main.async {
                self.response = response
                // FIXME: - Vista se coulta al subir los datos y en la pantalla perfil habra que hacer un obj obsever para hacer update de los datos nuevos.
                self.dismiss(animated: true, completion: nil)
                
                if response?.status == 1 {
                    self.displayAlert(title: "Cambios realizados", message: "Los cambios se han realizado con exito.")
                    
                } else if response?.status == 0 {
                    self.displayAlert(title: "Error", message: response?.msg ?? "Ha ocurrido un error, intentalo mas tarde.")
                    
                } else if errors == .errorConnection {
                    self.displayAlert(title: "Error", message: "Ha habido un error, intrentalo mas tarde.")
                    
                } else if errors == .badData {
                    self.displayAlert(title: "Error", message: "Ha habido un error, intrentalo mas tarde.")
                    
                } else {
                    self.displayAlert(title: "Error", message: "Ha habido un error, intrentalo mas tarde.")
                }
                
                
            }
        }
        
    }
    
    //MARK: -Añadir funcion para subir foto y quitarla de la vista de perfil principal.

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupColors(){
        profileView.backgroundColor = UIColor(named: "background_views")
    }
    
    // Funcion para instanciar alerts.
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    


}
