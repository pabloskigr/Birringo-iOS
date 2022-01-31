//
//  LoginVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 23/1/22.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var password_login: UITextField!
    @IBOutlet weak var email_login: UITextField!
    @IBOutlet weak var view_loginBox: UIView!
    @IBOutlet weak var passwordbutton: UIButton!
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
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            view.endEditing(true)
    }
    
    @IBAction func login_taped(_ sender: Any) {
        //Cuando pulse verificara las credenciales y ira al home.
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
}

