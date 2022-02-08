//
//  AjustesVC.swift
//  Birringo
//
//  Created by pabloGarcia on 7/2/22.
//

import UIKit

class AjustesVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    
    @IBOutlet weak var ajustesView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()

    }
    
    
    private func setupColors(){
        ajustesView.layer.cornerRadius = 30
        ajustesView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            <#code#>
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            <#code#>
        }
}
