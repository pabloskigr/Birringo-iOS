//
//  AjustesCell.swift
//  Birringo
//
//  Created by pabloGarcia on 31/1/22.
//

import UIKit

class AjustesCell: UITableViewCell {

    @IBOutlet weak var ajustesTitle: UILabel!
    
    @IBOutlet weak var ajustesView: UIView!
    
    var ajustesData:AjustesData? {
        didSet {renderUI()}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func renderUI(){
        guard let ajustesData = ajustesData else {return}
        ajustesTitle.text = ajustesData.title
        
    }

}
