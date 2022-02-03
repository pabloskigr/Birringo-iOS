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
        didSet {renderUI()}
    }
    
    var distance: Double? {
        didSet{renderUI()}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func renderUI(){
        guard let bares = bares else {return}
        barName.text = bares.title
       
        if distance ?? 0 > 1000 {
            distance = distance! / 1000
            barDistanceLabel.text = "\(round(distance ?? 0))km"
        } else {
            barDistanceLabel.text = "\(round(distance ?? 0))m"
        }
    }

}
