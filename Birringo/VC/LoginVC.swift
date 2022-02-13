//
//  LoginVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 23/1/22.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var email_login: UITextField!
    @IBOutlet weak var password_login: UITextField!
    @IBOutlet weak var view_loginBox: UIView!
    @IBOutlet weak var passwordbutton: UIButton!
    var params : [String : Any]?
    var response : Response?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        email_login.delegate = self
        password_login.delegate = self
    }
    
    private func setupColors(){
        view_loginBox.backgroundColor = UIColor(named: "background_white")
        view_loginBox.layer.cornerRadius = 30
        view_loginBox.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    //Al pulsar intro se oculta el teclado
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            view.endEditing(true)
    }
    
    @IBAction func login_taped(_ sender: Any) {
        params = [
            "email" : email_login.text ?? "",
            "password"  : password_login.text ?? ""
        ]
        
        if !email_login.text!.isEmpty &&  !password_login.text!.isEmpty {
            NetworkManager.shared.login(params: params){
                response, error in DispatchQueue.main.async {
                    self.response = response
                    if response?.status == 1 && response?.msg == "Login correcto" {
                        
                        Session.shared.api_token = response?.api_token
                        let defaults = UserDefaults.standard
                        defaults.set(Session.shared.api_token, forKey: "api_token")
                        
                        let mainTabBarController = self.storyboard!.instantiateViewController(identifier: "MainTabBarController")
                        mainTabBarController.modalPresentationStyle = .fullScreen
                        self.present(mainTabBarController, animated: true, completion: nil)
                    
                    } else if error == .badData {
                        let alert = UIAlertController(title: "Error", message: "\(response?.msg ?? "Ha habido un error")", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    } else if error == .errorConnection {
                        let alert = UIAlertController(title: "Error", message: "\(response?.msg ?? "Servidor no responde")", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    } else {
                        let alert = UIAlertController(title: "Error", message: "\(response?.msg ?? "Crendenciales no correctas")", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Campos vacios", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func signupTapped(_ sender: Any) {
        if let registerVC = storyboard?.instantiateViewController(identifier: "RegisterVC") as? RegisterVC {
        registerVC.modalPresentationStyle = .fullScreen
        registerVC.modalTransitionStyle = .crossDissolve
        self.present(registerVC, animated: true, completion: nil)
        }
    }
    @IBAction func passwordButton(_ sender: Any) {
        passwordbutton.isSelected = !passwordbutton.isSelected
        password_login.isSecureTextEntry.toggle()
    }
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        if let recoverPassVC = storyboard?.instantiateViewController(identifier: "RecoverPassVC") as? RecoverPassVC {
        recoverPassVC.modalPresentationStyle = .fullScreen
        recoverPassVC.modalTransitionStyle = .crossDissolve
        self.present(recoverPassVC, animated: true, completion: nil)
        }
    }
}

