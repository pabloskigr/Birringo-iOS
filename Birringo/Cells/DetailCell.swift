//
//  DetailCell.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 28/1/22.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet weak var barName: UILabel!
    var bares:Bares? {
        didSet {renderUI()}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func renderUI(){
        guard let bares = bares else {return}
        barName.text = bares.title
      
    }

}
