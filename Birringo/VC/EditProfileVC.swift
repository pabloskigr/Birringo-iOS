//
//  EditProfileVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 4/3/22.
//

import UIKit
import Photos
import Network

class EditProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var profileView: UIView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var biographyTextView: UITextView!
    @IBOutlet weak var telefonoTextField: UITextField!
    @IBOutlet weak var saveChangesButton: UIButton!
    
    let networkMonitor = NWPathMonitor()
    var userResponse : Response?
    var response : Response?
    var params : [String : Any]?
    var imageToChange : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        indicatorView.isHidden = true
        userTextField.delegate = self
        emailTextField.delegate = self
        biographyTextView.delegate = self
        telefonoTextField.delegate = self
        userImage.layer.cornerRadius = userImage.bounds.size.width / 2.0
        
        //MARK: - Funcion para comprobar conexion a internet y cargar los datos del usuario o no.
        checkInternetConnection()

    }
    
    func checkInternetConnection(){
        networkMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    if let _ = self.userResponse {
                        self.loadUserData()
                        self.networkMonitor.cancel()
                    } else {
                        self.errorConnectionAlert(title: "Error", message: "No se han podido cargar los datos, intentalo mas tarde.")
                        self.networkMonitor.cancel()
                    }
                }

            } else {
                DispatchQueue.main.async {
                    self.noConnection()
                    self.networkMonitor.cancel()
                }
            }
        }
        let queue = DispatchQueue.global(qos: .background)
            networkMonitor.start(queue: queue)
    }
    
    func noConnection(){
            saveChangesButton.isEnabled = false
            indicatorView.isHidden = false
            errorConnectionAlert(title: "Error de conexion", message: "No se han podido cargar los datos, intentalo mas tarde.")
    }
    
    func loadUserData(){
        
        if let userPhone = userResponse?.datos_perfil?.telefono{
            if userPhone != 0 {
                telefonoTextField.text = String(userPhone)
            } else {
                telefonoTextField.text = ""
                telefonoTextField.placeholder = "Telefono (Opcional)"
            }
        } else {
            telefonoTextField.text = ""
            telefonoTextField.placeholder = "Telefono (Opcional)"
        }
        
        userTextField.text = userResponse?.datos_perfil?.name?.capitalized
        emailTextField.text = userResponse?.datos_perfil?.email
        biographyTextView.text = userResponse?.datos_perfil?.biografia
        
        NetworkManager.shared.getImageFrom(imageUrl: userResponse?.datos_perfil?.imagen ?? ""){
            image in DispatchQueue.main.async {
    
                if let image = image {
                    self.userImage.image = image
                } else {
                    //Si el usuario no tiene imagen de perfil, se le asignara una por defecto.
                    self.userImage.image = UIImage(named: "user_img")!
                }
            }
        }
    }
    
    //MARK: - Funcion para guardar los cambios que haga el usuario.
    @IBAction func saveChangesTapped(_ sender: Any) {
        indicatorView.isHidden = false
        params = [
            "name" : userTextField.text ?? "",
            "email"  : emailTextField.text ?? "" ,
            "biografia" : biographyTextView.text ?? "",
            "telefono" : Int(telefonoTextField.text ?? "") ?? 0,
            
        ]
        
        NetworkManager.shared.editUserData(apiToken: Session.shared.api_token!, params: params){
            response, errors in DispatchQueue.main.async {
                self.response = response
                
                if response?.status == 1 {
                    //Si el usuario ha editado su foto de perfil la subiremos aqui, de lo contrario se volvera al perfil refescando los datos.
                    if let imageChanged = self.imageToChange {
                        self.uploadProfileImage(imageToUpload: imageChanged)
                    } else {
                        NotificationCenter.default.post(name: Notification.Name("reloadProfileData"), object: nil)
                        self.indicatorView.isHidden = true
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                } else if response?.status == 0 {
                    self.indicatorView.isHidden = true
                    self.displayAlert(title: "Error", message: response?.msg ?? "Ha ocurrido un error, intentalo mas tarde.")
                    
                } else if errors == .errorConnection {
                    self.indicatorView.isHidden = true
                    self.displayAlert(title: "Error", message: "Ha habido un error, intrentalo mas tarde.")
                    
                } else if errors == .badData {
                    self.indicatorView.isHidden = true
                    self.displayAlert(title: "Error", message: "Ha habido un error, intrentalo mas tarde.")
                    
                } else {
                    self.indicatorView.isHidden = true
                    self.displayAlert(title: "Error", message: "Ha habido un error, intrentalo mas tarde.")
                }
                
                
            }
        }
        
    }
    
    //MARK: -Funciones para cambiar la imagen de perfil
    @IBAction func imageChangeTapped(_ sender: Any) {
        
        let ac = UIAlertController(title: "Añade una foto de perfil", message: "Selecciona una imagen desde:", preferredStyle: .actionSheet)
        let cameraBtn = UIAlertAction(title: "Camera", style: .default) { (_)  in
            self.checkCameraPermissions()
        }
        let galleryBtn = UIAlertAction(title: "Galeria", style: .default) { (_)  in
            self.checkPhotoLibraryPermissions()
        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cameraBtn)
        ac.addAction(galleryBtn)
        ac.addAction(cancelBtn)
        self.present(ac, animated: true, completion: nil)
    }
    
    func checkCameraPermissions(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                self.showImagePicker(selectedSource: .camera)
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                        if granted {
                            self.showImagePicker(selectedSource: .camera)
                        }
                    }
            case .denied:
                displayAlert(title: "Permisos", message: "Los permisos para acceder a la camara han sido denegados, puedes cambiarlos desde ajustes.")
            case .restricted:
                displayAlert(title: "Permisos", message: "Los permisos para acceder a la camara han sido restringidos, puedes cambiarlos desde ajustes.")
        @unknown default:
                displayAlert(title: "Permisos", message: "Ha habido un error")
        }
    }
    
    func checkPhotoLibraryPermissions(){
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite){
            case .authorized:
                self.showImagePicker(selectedSource: .photoLibrary)
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { status in
                    if status == .authorized {
                        self.showImagePicker(selectedSource: .photoLibrary)
                    }
                }
            case .denied:
                displayAlert(title: "Permisos", message: "Los permisos para acceder a la galeria han sido denegados, puedes cambiarlos desde ajustes.")
            case .restricted:
                displayAlert(title: "Permisos", message: "Los permisos para acceder a la galeria han sido restringidos, puedes cambiarlos desde ajustes.")
            case .limited:
                displayAlert(title: "Permisos", message: "Los permisos para acceder a la galeria estan limitados, puedes cambiarlos desde ajustes.")
            @unknown default:
                displayAlert(title: "Permisos", message: "Ha habido un error")
            }
    }
    
    func showImagePicker(selectedSource: UIImagePickerController.SourceType){
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource) else {
            self.displayAlert(title: "Error", message: "El medio seleccionado no esta disponible, intentalo mas tarde.")
            return
        }
        DispatchQueue.main.async {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = selectedSource
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //Se mostrara la imagen como preview y se almacenara en una variable, pero no se guardara hasta que el usuario guarde los cambios.
        if let selectedImage = info[.editedImage] as? UIImage{
            userImage.image = selectedImage
            imageToChange = selectedImage //Aqui almacenamos la imagen para subirla si el usuario guarda los cambios.

        } else if let selectedImage = info[.originalImage] as? UIImage {
            userImage.image = selectedImage
            imageToChange = selectedImage //Aqui almacenamos la imagen para subirla si el usuario guarda los cambios.

        } else {
            self.displayAlert(title: "Error", message: "Ha habido un error")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Solo se llama a esta funcion cuando el usuario pulsa el boton de guardar cambios.
    func uploadProfileImage(imageToUpload : UIImage){
       
        let imageStringData = convertImageToBase64(image: imageToUpload)
        params = [
            "image" : imageStringData,
        ]
        
        NetworkManager.shared.uploadProfileImage(apiToken: Session.shared.api_token!, params: params){
            response, errors in DispatchQueue.main.async {
                self.indicatorView.isHidden = true
                self.response = response
                
                if response?.status == 1 {
                    NotificationCenter.default.post(name: Notification.Name("reloadProfileData"), object: nil)
                    self.dismiss(animated: true, completion: nil)
                    
                } else if response?.status == 0 {
                    //Si hay algun fallo a la hora de subir la imagen se le mostrara al usuario mediante un alert.
                    self.displayAlert(title: "Error", message: "\(response?.msg ?? "Se ha producido un error al subir la imagen.")")
                    
                } else if errors == .badData || errors == .errorConnection {
                    self.displayAlert(title: "Error", message: "Ha habido un error, intentalo mas tarde")
                    
                } else {
                    self.displayAlert(title: "Error", message: "Ha habido un error, intentalo mas tarde")
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Funcion para convertir imagen a base64 con el fin de enviarlo posteriormente al servidor donde se almacenara.
    func convertImageToBase64(image: UIImage) -> String {
            let imageData = image.jpegData(compressionQuality: 0.6)!
            return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupColors(){
        profileView.backgroundColor = UIColor(named: "background_views")
    }
    
    //MARK: - Funcion para ocultar el teclado.
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            view.endEditing(true)
    }
    
    //MARK: - Alerts
    func errorConnectionAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action) in self.dismiss(animated: true, completion: nil) }))
        //Si hay error de conexion se mostrara este alert y a la vez se cerrara la vista modal de editar.
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    


}
