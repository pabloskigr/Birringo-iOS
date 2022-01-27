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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        username_register.delegate = self
        email_register.delegate = self
        phone_register.delegate = self
        password_register.delegate = self
        setupColors()
        view_registerBox.layer.cornerRadius = 30
        view_registerBox.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
 
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            view.endEditing(true)
    }
    
    @IBAction func signinTapped(_ sender: Any) {
        if let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginVC {
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    @IBAction func registerBtnTapped(_ sender: Any) {
        if let tutorialVC = self.storyboard?.instantiateViewController(identifier: "OnboardingVC") as? OnboardingVC {
            self.navigationController?.pushViewController(tutorialVC, animated: true)
        }
    }
    private func setupColors(){
        view_registerBox.backgroundColor = UIColor(named: "background_white")
    }

}

