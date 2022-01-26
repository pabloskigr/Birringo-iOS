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
        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
       //contentView.backgroundColor = UIColor(named: "background_views")
    }
    
    private func renderUI(){
        guard let perfilData = perfilData else {return}
        settingTitle.text = perfilData.title
        settingIcons.image = perfilData.image
    }
    
}
