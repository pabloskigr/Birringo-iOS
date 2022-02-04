//
//  DetailCell.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 28/1/22.
//

import UIKit

class DetailCell: UITableViewCell {
    
    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var barDistanceLabel: UILabel!
    var bares:Bares? {
        didSet {
            renderUI()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func renderUI(){
        guard var bares = bares else {return}
        barName.text = bares.title
        if bares.distance ?? 0 > 1000 {
            bares.distance = bares.distance! / 1000
            barDistanceLabel.text = "\(round(bares.distance ?? 0))km"
        } else {
            barDistanceLabel.text = "\(round(bares.distance ?? 0))m"
        }
    }

}
