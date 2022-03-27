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
        animationView.frame = view.bounds
        // Add animationView as subview
        animationView.contentMode = .scaleAspectFill
        view.addSubview(animationView)
        animationView.play()
      
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
