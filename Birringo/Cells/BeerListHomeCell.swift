//
//  HomeTVCell.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 25/1/22.
//

import UIKit

class BeerListHomeCell: UITableViewCell {
    
 
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerTitle: UILabel!
    @IBOutlet weak var beerGraduation: UILabel!
    @IBOutlet weak var beerType: UILabel!
    
    var data:Beer? {
        didSet {renderUI()}
    }

    private func renderUI(){
        guard let data = data else {
            return
        }
        beerImage.image = nil
        beerImage.layer.cornerRadius = 6
        beerTitle.text = data.titulo ?? "No hay titulo"
        beerType.text = data.tipo ?? "No hay tipo"
        beerGraduation.text = "\(data.graduacion ?? "0")%"
        
        NetworkManager.shared.getImageFrom(imageUrl: data.imagen ?? ""){
            image in DispatchQueue.main.async {
                if let image = image {
                    self.beerImage.image = image
                } else {
                    //Si el usuario del cual obtenemos los datos no tiene imagen de perfil en la base de datos se le asignara na por defecto.
                    self.beerImage.image = UIImage(named: "cerveza-almeria")!
                }
            }
        }
    }
    
    
    
    
    
}
