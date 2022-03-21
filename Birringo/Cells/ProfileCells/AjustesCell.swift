//
//  AjustesCell.swift
//  Birringo
//
//  Created by pabloGarcia on 21/3/22.
//

import UIKit

class AjustesCell: UITableViewCell {

//    struct AjustesData {
//        var title: String
//    }

    
    @IBOutlet weak var ajustesTitle: UILabel!
    var ajustesData:AjustesData? {
        didSet {renderUI()}
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
//    static let ajustes: [AjustesData] = [
//        AjustesData(title: "POLITICA DE PRIVACIDAD"),
//        AjustesData(title: "TUTORIAL"),
//        AjustesData(title: "TERMINOS LEGALES")
//    ]
    private func renderUI(){
        guard let ajustesData = ajustesData else {return}
        ajustesTitle.text = ajustesData.title
    }

}
