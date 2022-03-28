//
//  GamificacionVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 27/1/22.
//

import UIKit
import CoreLocation
import SkeletonView

class GamificacionVC: UIViewController, SkeletonTableViewDataSource, UITableViewDelegate {
 
    @IBOutlet var gamificacionView: UIView!
    @IBOutlet weak var userRankingView: UIView!
    @IBOutlet weak var gamificacion_tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var userPosition: UILabel!
    @IBOutlet weak var userPositionImage: UIImageView!
    @IBOutlet weak var userPositionName: UILabel!
    @IBOutlet weak var userPositionPoints: UILabel!
    var nib = UINib(nibName: "RankingCell", bundle: nil)
    var counter = 0
    var response : Response?
    var userPositionResponse : Response?
    var titleToReturn : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        userPositionName.text = nil
        userPositionPoints.text = nil
        userPosition.text = nil
        userPositionImage.image = nil
        gamificacion_tableView.delegate = self
        gamificacion_tableView.dataSource = self
        gamificacion_tableView.register(nib, forCellReuseIdentifier: "RankingCellid")
        
        segmentedControl.selectedSegmentIndex = counter
        loadSkeletonView()
        loadUserSkeleton()
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
    
    func loadSkeletonView(){
        gamificacion_tableView.isSkeletonable = true
        gamificacion_tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .silver), animation: nil, transition: .crossDissolve(0.25))
    }
    
    func loadUserSkeleton(){
        userRankingView.isSkeletonable = true
        userRankingView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .silver), animation: nil, transition: .crossDissolve(0.25))
    }
    
    func checkSegmentedIndex(){
        loadSkeletonView()
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
        
         switch selectedIndex
         {
         case 0:
             nib = UINib(nibName: "RankingCell", bundle: nil)
             gamificacion_tableView.register(nib, forCellReuseIdentifier: "RankingCellid")
             titleToReturn = "Top 50"
             loadUserSkeleton()
             getRanking()
         case 1:
             nib = UINib(nibName: "QuestCell", bundle: nil)
             gamificacion_tableView.register(nib, forCellReuseIdentifier: "QuestCellid")
             titleToReturn = "Ultimos retos"
             userRankingView.isHidden = true
             getQuests()
         default:
             getRanking()
         }
    }
    
    func getRanking(){
        
        userRankingView.isHidden = false
        
        NetworkManager.shared.getRanking(apiToken: Session.shared.api_token!){
            response, errors in DispatchQueue.main.async {
        
                if response?.status == 1 {
                    self.response = response
                    self.getUserPositionInRanking()
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
                    self.view.hideSkeleton(reloadDataAfter: true)
                    self.gamificacion_tableView.stopSkeletonAnimation()
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
    
    func getUserPositionInRanking(){
        
        NetworkManager.shared.getUserPositionInRanking(apiToken: Session.shared.api_token!) {
            response, errors in DispatchQueue.main.async {
                self.view.hideSkeleton(reloadDataAfter: true)
                self.userRankingView.hideSkeleton(reloadDataAfter: true)
                self.gamificacion_tableView.stopSkeletonAnimation()
                
                if response?.status == 1 {
                    self.userPositionResponse = response
                    self.userPosition.text = "\(self.userPositionResponse?.posicion ?? 0)"
                    self.userPositionName.text = self.userPositionResponse?.datos_perfil?.name
                    self.userPositionPoints.text = "\(self.userPositionResponse?.datos_perfil?.puntos ?? 0) pt"
                    
                    NetworkManager.shared.getImageFrom(imageUrl: self.userPositionResponse?.datos_perfil?.imagen ?? ""){
                        image in DispatchQueue.main.async {
                
                            if let image = image {
                                self.userPositionImage.image = image
                                self.userPositionImage.layer.cornerRadius = self.userPositionImage.bounds.size.width / 2.0
                            } else {
                                //Si el usuario no tiene imagen de perfil, se le asignara una por defecto.
                                self.userPositionImage.image = UIImage(named: "user_img")!
                            }
                        }
                    }
                    
                } else if response?.status == 0 {
                    
                } else if errors == .badData {
                    self.displayAlert(title: "Error", message: "Ha ocurrido un error, intentalo mas tarde.")
                } else if errors == .errorConnection {
                    self.displayAlert(title: "Error", message: "Ha ocurrido un error, intentalo mas tarde.")
                } else {
                    self.displayAlert(title: "Error", message: "Ha ocurrido un error, intentalo mas tarde.")
                }
            }
        }
        
    }
    //Skeleton Table View
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
         switch selectedIndex
         {
         case 0:
             return "RankingCellid"
         case 1:
             return "QuestCellid"
         default:
             return "RankingCellid"
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
        userRankingView.backgroundColor = UIColor(named: "background_views")
    }
    
    // Funcion para instanciar alerts.
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
