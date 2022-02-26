//
//  QuestCell.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 27/1/22.
//

import UIKit

class QuestCell: UITableViewCell {

    @IBOutlet weak var questTitle: UILabel!
    @IBOutlet weak var questPoints: UILabel!
    
    var questData : Quest? {
        didSet {renderUI()}
    }
    
    private func renderUI(){
        guard let questData = questData else {return}
        questTitle.text = questData.titulo
        questPoints.text = "\(questData.puntos) pt"

    }
    
}
