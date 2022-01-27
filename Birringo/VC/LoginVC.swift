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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        email_login.delegate = self
        password_login.delegate = self
        setupColors()
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
        if let registerVC = self.storyboard?.instantiateViewController(identifier: "RegisterVC") as? RegisterVC {
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
    }
    private func setupColors(){
        view_loginBox.backgroundColor = UIColor(named: "background_white")
    }
}

