//
//  PerfilOpstionsCell.swift
//  Birringo
//
//  Created by APPS2T on 26/1/22.
//

import UIKit

class PerfilOpstionsCell: UITableViewCell {

    @IBOutlet weak var settingIcons: UIImageView!
    @IBOutlet weak var settingTitle: UILabel!
    var perfilData:PerfilData? {
        didSet {renderUI()}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func renderUI(){
        guard let perfilData = perfilData else {return}
        settingTitle.text = perfilData.title
        settingIcons.image = perfilData.image
    }
    
}
