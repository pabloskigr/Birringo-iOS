//
//  RankingCell.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 27/1/22.
//

import UIKit

class RankingCell: UITableViewCell {

    @IBOutlet weak var rankingPosition: UILabel!
    @IBOutlet weak var rankingImage: UIImageView!
    @IBOutlet weak var rankingName: UILabel!
    @IBOutlet weak var rankingPoints: UILabel!
    
    var rankingData : UserData? {
        didSet {renderUI()}
    }
    
    private func renderUI(){
        guard let rankingData = rankingData else {return}
        rankingImage.image = nil
        rankingImage.layer.cornerRadius = rankingImage.bounds.size.width / 2.0
        rankingName.text = rankingData.name
        rankingPoints.text = "\(rankingData.puntos ?? 0) pt"
        
        NetworkManager.shared.getImageFrom(imageUrl: rankingData.imagen ?? ""){
            image in DispatchQueue.main.async {
                //self.indicatorView.isHidden = true
                if let image = image {
                    self.rankingImage.image = image
                } else {
                    //Si el usuario no tiene imagen de perfil en la base de datos se le asignara na por defecto.
                    self.rankingImage.image = UIImage(named: "user_img")!
                }
            }
            
        }

    }
    
}
