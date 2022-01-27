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
    var questData:QuestData? {
        didSet {renderUI()}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func renderUI(){
        guard let questData = questData else {return}
        questTitle.text = questData.title
        questPoints.text = "\(questData.points) pt"

    }
    
}
