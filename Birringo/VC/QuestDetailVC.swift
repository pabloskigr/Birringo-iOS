//
//  QuestDetailVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 28/1/22.
//

import UIKit

class QuestDetailVC: UIViewController {
    
    
    var questData : QuestData?
    @IBOutlet weak var questTitle: UILabel!
    @IBOutlet weak var questLocation: UILabel!
    @IBOutlet weak var questPoints: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questTitle.text = questData?.title
        questLocation.text = questData?.localizacion
        questPoints.text = "Puntos: \(questData?.points ?? 0)"
    }
    

    @IBAction func ScannerButtonTapped(_ sender: Any) {
        //Abrir scanenr QR
    }
    
    @IBAction func MapsButtonTapped(_ sender: Any) {
        //Abrir mapa con ubicacion del quest
    }
    
}
