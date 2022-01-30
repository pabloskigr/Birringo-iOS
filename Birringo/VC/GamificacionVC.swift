//
//  GamificacionVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 27/1/22.
//

import UIKit

class GamificacionVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
 

    @IBOutlet var gamificacionView: UIView!
    @IBOutlet weak var gamificacion_tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var nib = UINib(nibName: "RankingCell", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        gamificacion_tableView.delegate = self
        gamificacion_tableView.dataSource = self
        gamificacion_tableView.register(nib, forCellReuseIdentifier: "RankingCellid")
    }
    
    private func setupColors(){
        gamificacionView.backgroundColor = UIColor(named: "background_views")
        gamificacion_tableView.backgroundColor = UIColor(named: "background_white")
        gamificacion_tableView.layer.cornerRadius = 30
        gamificacion_tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func OnChangedSegmentedControl(_ sender: UISegmentedControl) {
        self.gamificacion_tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
         switch selectedIndex
         {
         case 0:
             return MockData.ranking.count
         case 1:
             return MockData.quest.count
         default:
             return 0
         }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
          switch selectedIndex
          {
          case 0:
              nib = UINib(nibName: "RankingCell", bundle: nil)
              gamificacion_tableView.register(nib, forCellReuseIdentifier: "RankingCellid")
              let cell = tableView.dequeueReusableCell(withIdentifier: "RankingCellid", for: indexPath) as! RankingCell
              cell.rankingData = MockData.ranking[indexPath.row]
              cell.rankingPosition.text = "\(indexPath.row + 1)"
              cell.backgroundColor = UIColor(named: "background_white")
              return cell
          case 1:
              nib = UINib(nibName: "QuestCell", bundle: nil)
              gamificacion_tableView.register(nib, forCellReuseIdentifier: "QuestCellid")
              let cell = tableView.dequeueReusableCell(withIdentifier: "QuestCellid", for: indexPath) as! QuestCell
              cell.questData = MockData.quest[indexPath.row]
              cell.backgroundColor = UIColor(named: "background_white")
              return cell
          default:
              return UITableViewCell()
          }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gamificacion_tableView.deselectRow(at: indexPath, animated: true)
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
          switch selectedIndex
          {
          case 1:
              if let questDetailVC = storyboard?.instantiateViewController(withIdentifier: "QuestDetailVC") as? QuestDetailVC {
                  questDetailVC.questData = MockData.quest[indexPath.row]
                  navigationController?.pushViewController(questDetailVC, animated: true)
              }
          default:
              gamificacion_tableView.deselectRow(at: indexPath, animated: true)
          }
    }
    
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String? {
        
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
         switch selectedIndex
         {
         case 0:
             return "Top 100"
         case 1:
             return "Ultimos retos"
         default:
             return ""
         }
    }
    
    



}
