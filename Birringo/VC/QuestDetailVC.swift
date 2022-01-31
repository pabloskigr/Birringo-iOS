//
//  QuestDetailVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 28/1/22.
//

import UIKit
import CoreLocation

class QuestDetailVC: UIViewController {
    
    var questData : QuestData?
    @IBOutlet var questView: UIView!
    @IBOutlet weak var questViewBox: UIView!
    @IBOutlet weak var questTitle: UILabel!
    @IBOutlet weak var questLocation: UILabel!
    @IBOutlet weak var questPoints: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questTitle.text = questData?.title
        questLocation.text = String((questData?.location[0].title) ?? "")
        questPoints.text = "Puntos: \(questData?.points ?? 0)"
        setupColors()
    }
    
    func setupColors(){
        questView.backgroundColor = UIColor(named: "background_views")
        questViewBox.backgroundColor = UIColor(named: "background_white")
    }
    

    @IBAction func ScannerButtonTapped(_ sender: Any) {
        if let qrVC = storyboard?.instantiateViewController(identifier: "QRVC") as? QRVC {
            qrVC.modalPresentationStyle = .fullScreen
            qrVC.modalTransitionStyle = .crossDissolve
        self.present(qrVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func MapsButtonTapped(_ sender: Any) {
        
        if let mapsVC = storyboard?.instantiateViewController(withIdentifier: "MapsVC") as? MapsVC {
            let latidud = questData?.location[0].latitud
            let longitud = questData?.location[0].longitud
            mapsVC.barName = questData?.location[0].title
            mapsVC.coordenadas = CLLocationCoordinate2DMake(latidud!, longitud!)
            navigationController?.pushViewController(mapsVC, animated: true)
        }
    }
    
}
