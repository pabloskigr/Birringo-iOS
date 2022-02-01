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
    
    var distance: Int? {
        didSet{renderUI()}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func renderUI(){
        guard let bares = bares else {return}
        barName.text = bares.title
        barDistanceLabel.text = "\(distance ?? 0)m"
    }

}
