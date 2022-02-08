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
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        if let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginVC {
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .crossDissolve
        self.present(loginVC, animated: true, completion: nil)
        }
    }
}
