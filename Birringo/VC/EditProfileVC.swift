//
//  EditProfileVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 4/3/22.
//

import UIKit
import Photos

class EditProfileVC: UIViewController {
    
    @IBOutlet var profileView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var biographyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setupColors(){
        profileView.backgroundColor = UIColor(named: "background_views")
    }
    
    @IBAction func saveChangesTapped(_ sender: Any) {
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        //Dissmiss view.
    }
    


}
