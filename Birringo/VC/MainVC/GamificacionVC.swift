//
//  GamificacionVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 27/1/22.
//

import UIKit
import CoreLocation

class GamificacionVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
 

    @IBOutlet var gamificacionView: UIView!
    @IBOutlet weak var gamificacion_tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var nib = UINib(nibName: "RankingCell", bundle: nil)
    var counter = 0
    var response : Response?
    var titleToReturn : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        gamificacion_tableView.delegate = self
        gamificacion_tableView.dataSource = self
        gamificacion_tableView.register(nib, forCellReuseIdentifier: "RankingCellid")
        
        segmentedControl.selectedSegmentIndex = counter
        getRanking()
    
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handlegesture(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handlegesture(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @IBAction func OnChangedSegmentedControl(_ sender: UISegmentedControl) {
        counter = segmentedControl.selectedSegmentIndex
        checkSegmentedIndex()
    }
    
    func checkSegmentedIndex(){
        //self.indicatorView.isHidden = false
        
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
         switch selectedIndex
         {
         case 0:
             nib = UINib(nibName: "RankingCell", bundle: nil)
             gamificacion_tableView.register(nib, forCellReuseIdentifier: "RankingCellid")
             titleToReturn = "Top 100"
             getRanking()
         case 1:
             nib = UINib(nibName: "QuestCell", bundle: nil)
             gamificacion_tableView.register(nib, forCellReuseIdentifier: "QuestCellid")
             titleToReturn = "Ultimos retos"
             getQuests()
         default:
             getRanking()
         }
    }
    
    func getRanking(){
        
        NetworkManager.shared.getRanking(apiToken: Session.shared.api_token!){
            response, errors in DispatchQueue.main.async {
                if response?.status == 1 {
                    self.response = response
                    self.gamificacion_tableView.reloadData()
                    
                } else if errors == .badData {
                    self.displayAlert(title: "Error", message: "Ha habido un error")
                    
                } else if errors == .errorConnection {
                    self.displayAlert(title: "Error", message: "El servidor no responde")
                    
                } else if response?.status == 0 {
                    //Si hay algun fallo se le mostrara al usuario mediante un alert.
                    self.displayAlert(title: "Error", message: "\(response?.msg ?? "Se ha producido un error")")
                }
            }
        }
        
    }
    
    func getQuests(){
        
        NetworkManager.shared.getQuests(apiToken: Session.shared.api_token!){
            response, errors in DispatchQueue.main.async {
                if response?.status == 1 {
                    self.response = response
                    self.gamificacion_tableView.reloadData()
                    
                } else if errors == .badData {
                    self.displayAlert(title: "Error", message: "Ha habido un error")
                    
                } else if errors == .errorConnection {
                    self.displayAlert(title: "Error", message: "El servidor no responde")
                    
                } else if response?.status == 0 {
                    //Si hay algun fallo se le mostrara al usuario mediante un alert.
                    self.displayAlert(title: "Error", message: "\(response?.msg ?? "Se ha producido un error")")
                }
            }
        }
        
    }
    
 
    //TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
         switch selectedIndex
         {
         case 0:
             return response?.ranking?.count ?? 0
         case 1:
             return response?.quests?.count ?? 0
         default:
             return 0
         }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
          switch selectedIndex
          {
          case 0:
              let cell = tableView.dequeueReusableCell(withIdentifier: "RankingCellid", for: indexPath) as! RankingCell
              cell.rankingData = response?.ranking![indexPath.row]
              cell.rankingPosition.text = "\(indexPath.row + 1)"
              cell.backgroundColor = UIColor(named: "background_white")
              return cell
          case 1:
              let cell = tableView.dequeueReusableCell(withIdentifier: "QuestCellid", for: indexPath) as! QuestCell
              cell.questData = response?.quests![indexPath.row]
              cell.backgroundColor = UIColor(named: "background_white")
              return cell
          default:
              return UITableViewCell()
          }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gamificacion_tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
        if selectedIndex == 1 {
            if let questDetailVC = storyboard?.instantiateViewController(withIdentifier: "QuestDetailVC") as? QuestDetailVC {
                questDetailVC.questData = response?.quests![indexPath.row]
                print(response?.quests![indexPath.row])
                navigationController?.pushViewController(questDetailVC, animated: true)
            }
        }
    }
    
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String? {
        return titleToReturn ?? ""
    }
    
    @objc func handlegesture(gesture: UISwipeGestureRecognizer){
        if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            segmentedControl.selectedSegmentIndex = 1
            checkSegmentedIndex()
        }
        
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            segmentedControl.selectedSegmentIndex = 0
            checkSegmentedIndex()
        }
    }
    
    private func setupColors(){
        gamificacionView.backgroundColor = UIColor(named: "background_views")
        gamificacion_tableView.backgroundColor = UIColor(named: "background_white")
        gamificacion_tableView.layer.cornerRadius = 30
        gamificacion_tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    // Funcion para instanciar alerts.
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
