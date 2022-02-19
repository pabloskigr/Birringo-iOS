//
//  FavoritosCell.swift
//  Birringo
//
//  Created by APPS2T on 27/1/22.
//

import UIKit

class FavoritosCell: UITableViewCell {

    
    @IBOutlet weak var favoritosTitle: UILabel!
    @IBOutlet weak var favoritosIcons: UIImageView!
    var favoritosData:beerData? {
        didSet {renderUI()}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func renderUI(){
        guard let favoritosData = favoritosData else {return}
        favoritosTitle.text = favoritosData.titulo
        favoritosIcons.image = favoritosData.image
    }

}
