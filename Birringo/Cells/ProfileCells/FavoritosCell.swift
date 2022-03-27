//
//  FavoritosCell.swift
//  Birringo
//
//  Created by APPS2T on 27/1/22.
//

import UIKit

class FavoritosCell: UITableViewCell {

    
    @IBOutlet weak var favoritosTitle: UILabel!
    @IBOutlet weak var favoritosImage: UIImageView!
    var favoritosData:Beer? {
        didSet {renderUI()}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func renderUI(){
        guard let favoritosData = favoritosData else {return}
        favoritosTitle.text = favoritosData.titulo
        self.favoritosImage.layer.cornerRadius = 10
        
        NetworkManager.shared.getImageFrom(imageUrl: favoritosData.imagen ?? ""){
            image in DispatchQueue.main.async {
                if let image = image {
                    self.favoritosImage.image = image
                } else {
                    self.favoritosImage.image = UIImage(named: "cerveza-almeria")
                }
            }
        }
    }

}
