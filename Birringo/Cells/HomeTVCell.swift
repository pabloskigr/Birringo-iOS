//
//  HomeTVCell.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 25/1/22.
//

import UIKit

class HomeTVCell: UITableViewCell {
    
    @IBOutlet weak var title_cell: UILabel!
    @IBOutlet weak var ml_cell: UILabel!
    @IBOutlet weak var image_cell: UIImageView!
    
    var data:beerData? {
        didSet {renderUI()}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
       //contentView.backgroundColor = UIColor(named: "background_views")
    }
    
    private func renderUI(){
        guard let data = data else {return}
        title_cell.text = data.titulo
        ml_cell.text = "\(data.ml)ml"
        image_cell.image = data.image
    }
    
    
    
    
    
}
