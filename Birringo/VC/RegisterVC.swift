//
//  RegisterVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 24/1/22.
//

import UIKit

class RegisterVC: UIViewController, UITextFieldDelegate{
    
    //añadir view
    @IBOutlet weak var username_register: UITextField!
    @IBOutlet weak var email_register: UITextField!
    @IBOutlet weak var view_registerBox: UIView!
    @IBOutlet weak var phone_register: UITextField!
    @IBOutlet weak var password_register: UITextField!
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var passwordButton: UIButton!
    
    var response : Response?
    var params :  [String : Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        username_register.delegate = self
        email_register.delegate = self
        phone_register.delegate = self
        password_register.delegate = self
    }
    
    private func setupColors(){
        view_registerBox.backgroundColor = UIColor(named: "background_white")
        view_registerBox.layer.cornerRadius = 30
        view_registerBox.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    //Al pulsar intro se oculta el teclado
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            view.endEditing(true)
    }
    @IBAction func signinTapped(_ sender: Any) {
        if let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginVC {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
        self.present(loginVC, animated: true, completion: nil)
        }
    }
    @IBAction func registerBtnTapped(_ sender: Any) {
     
        params = [
            "name" : username_register.text ?? "",
            "email" : email_register.text ?? "",
            "password" : password_register.text ?? "",
            "telefono" : Int(phone_register.text ?? "") ?? 0
        ]
        
        if !password_register.text!.isEmpty && !username_register.text!.isEmpty && !email_register.text!.isEmpty {
            if checkboxButton.isSelected{
                NetworkManager.shared.registerUser(params: params){
                    response, error  in DispatchQueue.main.async {
                        self.response = response
                        if response?.status == 1 && response?.msg == "Registro completado" {
                            
                            Session.shared.api_token = response?.api_token
                            let defaults = UserDefaults.standard
                            defaults.set(Session.shared.api_token, forKey: "api_token")
          
                            if let tutorialVC = self.storyboard?.instantiateViewController(identifier: "OnboardingVC") as? OnboardingVC {
                                tutorialVC.modalPresentationStyle = .fullScreen
                                tutorialVC.modalTransitionStyle = .crossDissolve
                            self.present(tutorialVC, animated: true, completion: nil)
                            }
                        } else if error == .badData {
                            let alert = UIAlertController(title: "Error", message: "Ha habido un error", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        } else if error == .errorConnection {
                            let alert = UIAlertController(title: "Error", message: "Servidor no responde", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                        } else {
                            let alert = UIAlertController(title: "Datos no validos", message: "\(response?.msg ?? "Datos introducidos no validos")", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
            else {
                let alert = UIAlertController(title: "Terminos y condiciones", message: "Acepta los terminos y condiciones", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Faltan campos por rellenar", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
 
    @IBAction func checkboxTapped(_ sender: Any) {
        checkboxButton.isSelected = !checkboxButton.isSelected
    }
    @IBAction func passwordButton(_ sender: Any) {
        passwordButton.isSelected = !passwordButton.isSelected
        password_register.isSecureTextEntry.toggle()
    }
}

