//
//  RegisterVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 24/1/22.
//

import UIKit

class RegisterVC: UIViewController {
    
    //añadir view
    @IBOutlet weak var view_registerBox: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< Updated upstream
        self.navigationItem.hidesBackButton = true
=======
<<<<<<< HEAD
        self.navigationItem.hidesBackButton = true
=======
>>>>>>> develop
>>>>>>> Stashed changes
        setupColors()
        view_registerBox.layer.cornerRadius = 30
        view_registerBox.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func signinTapped(_ sender: Any) {
        if let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginVC {
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
<<<<<<< Updated upstream
=======
<<<<<<< HEAD
>>>>>>> Stashed changes
    @IBAction func registerBtnTapped(_ sender: Any) {
        if let tutorialVC = self.storyboard?.instantiateViewController(identifier: "OnboardingVC") as? OnboardingVC {
            self.navigationController?.pushViewController(tutorialVC, animated: true)
        }
    }
<<<<<<< Updated upstream
=======
=======
>>>>>>> develop
>>>>>>> Stashed changes
    private func setupColors(){
        view_registerBox.backgroundColor = UIColor(named: "background")
    }

}

