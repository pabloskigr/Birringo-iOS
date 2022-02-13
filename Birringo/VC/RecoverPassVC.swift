//
//  RecoverPassVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 8/2/22.
//

import UIKit

class RecoverPassVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var recoverPassView: UIView!
    var response : Response?
    var params : [String : Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        emailTextField.delegate = self
        

    }
    private func setupColors(){
        recoverPassView.backgroundColor = UIColor(named: "background_white")
        emailTextField.backgroundColor = UIColor(named: "background_white")
        recoverPassView.layer.cornerRadius = 30
        recoverPassView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    @IBAction func sendButtonTapped(_ sender: Any) {
        
        params = [
            "email" : emailTextField.text ?? ""
        ]
        
        if !emailTextField.text!.isEmpty && emailTextField.text != nil {
            NetworkManager.shared.recoverPassword(params: params){
                response, error in DispatchQueue.main.async {
                    self.response = response
                    if response?.status == 1 && response?.msg == "Se ha enviado una contraseña nueva a tu email" {
                        let alert = UIAlertController(title: "Email enviado", message: "\(response?.msg ?? "Email enviado")", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    } else if error == .errorConnection {
                        let alert = UIAlertController(title: "Error", message: "\(response?.msg ?? "Servidor no responde")", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    } else {
                        let alert = UIAlertController(title: "Error", message: "\(response?.msg ?? "Email no encontrado")", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "El campo email no puede estar vacio", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        if let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginVC {
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .crossDissolve
        self.present(loginVC, animated: true, completion: nil)
        }
    }
}
