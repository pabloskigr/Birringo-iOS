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
    
    var rankingData:RankingData? {
        didSet {renderUI()}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func renderUI(){
        guard let rankingData = rankingData else {return}
        rankingImage.image = rankingData.image
        rankingName.text = rankingData.username
        rankingPoints.text = "\(rankingData.userPoints) pt"

    }
    
}
