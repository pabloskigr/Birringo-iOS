//
//  LaunchScreenVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 23/1/22.
//

import UIKit
import Lottie

class LaunchScreenVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let jsonName = "beer_splash"
        let animation = Animation.named(jsonName)
        // Load animation to AnimationView
        let animationView = AnimationView(animation: animation)
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        // Add animationView as subview
        view.addSubview(animationView)
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    animationView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                    animationView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                    animationView.topAnchor.constraint(equalTo: self.view.topAnchor),
                    animationView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
                ])
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.checkApiToken()
        }
        
    }
    
    func checkApiToken(){
        if UserDefaults.standard.string(forKey: "api_token") != nil{
            Session.shared.api_token = UserDefaults.standard.string(forKey: "api_token")
            toHomeview()
        } else {
            if let loginVC = storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginVC {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            self.present(loginVC, animated: true, completion: nil)
            }
        }
    }
    
    func toHomeview(){
        let mainTabBarController = storyboard!.instantiateViewController(identifier: "MainTabBarController")
        mainTabBarController.modalPresentationStyle = .fullScreen
        self.present(mainTabBarController, animated: true, completion: nil)
    }
}
