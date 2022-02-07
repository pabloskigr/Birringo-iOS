//
//  AjustesVC.swift
//  Birringo
//
//  Created by pabloGarcia on 7/2/22.
//

import UIKit

class AjustesVC: UIViewController{
    
    
    @IBOutlet weak var ajustesView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()

    }
    
    
    private func setupColors(){
        ajustesView.layer.cornerRadius = 30
        ajustesView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
       
    }
}
