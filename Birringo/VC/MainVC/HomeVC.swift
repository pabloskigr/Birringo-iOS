//
//  HomeVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 24/1/22.
//

import UIKit

class HomeVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
  
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var home_tableView: UITableView!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet var home_view: UIView!
    @IBOutlet weak var segmentedControlHome: UISegmentedControl!
    @IBOutlet weak var indicatorView: UIView!
    
    var counter = 0
    var response : Response?
    var titleToReturn = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupColors()
        searchBar.delegate = self
        home_tableView.dataSource = self
        home_tableView.delegate = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        segmentedControlHome.selectedSegmentIndex = counter
        getBeers(tipo: "IPA")
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handlegesture(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handlegesture(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    private func setupColors(){
        tabBarController?.tabBar.backgroundColor = UIColor(named: "background_views")
        home_tableView.backgroundColor = UIColor(named: "background_white")
        searchTableView.backgroundColor = UIColor(named: "background_white")
        home_view.backgroundColor = UIColor(named: "background_views")
        searchView.backgroundColor = UIColor(named: "background_views")
        home_tableView.layer.cornerRadius = 30
        searchTableView.layer.cornerRadius = 30
        home_tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        searchTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    //Segmented control functions
    @IBAction func onChangedSegmentedControl(_ sender: UISegmentedControl) {
        counter = segmentedControlHome.selectedSegmentIndex
        checkSegmentedIndex()
    }
    
    @objc func handlegesture(gesture: UISwipeGestureRecognizer){
        
        if gesture.direction == UISwipeGestureRecognizer.Direction.left && counter < 4 {
            counter += 1
            segmentedControlHome.selectedSegmentIndex = counter
            checkSegmentedIndex()
        }
        if gesture.direction == UISwipeGestureRecognizer.Direction.right && counter > 0 {
            counter -= 1
            segmentedControlHome.selectedSegmentIndex = counter
            checkSegmentedIndex()
        }
    }
    
 
    func checkSegmentedIndex(){
        self.indicatorView.isHidden = false
        
        let selectedIndex = self.segmentedControlHome.selectedSegmentIndex
         switch selectedIndex
         {
         case 0:
             getBeers(tipo: "IPA")
         case 1:
             getBeers(tipo: "Ale")
         case 2:
             getBeers(tipo : "Rubia")
         case 3:
             getBeers(tipo : "Rubia")
         case 4:
             getBeers(tipo : "Rubia")
         default:
             getBeers(tipo: "IPA")
         }
    }
    
    func getBeers(tipo : String){
        NetworkManager.shared.obtenerCervezasTiposMain(apiToken: Session.shared.api_token!, tipo: tipo){
            response, errors in DispatchQueue.main.async {
                self.response = response
                self.indicatorView.isHidden = true
                
                if response?.status == 1 && response?.msg == "Cervezas encontradas" {
                    self.titleToReturn = tipo
                    self.home_tableView.reloadData()

                } else if errors == .badData {
                    self.displayAlert(title: "Error", message: "Ha habido un error")
                    
                } else if errors == .errorConnection {
                    self.displayAlert(title: "Error", message: "El servidor no responde")
                    
                } else if response?.status == 0 {
                    //Si hay algun fallo nos devolvera el error en el response y se le mostrara al usuario mediante un alert
                    self.displayAlert(title: "Error", message: "\(response?.msg ?? "Se ha producido un error")")
                }
            }
        }
    }
    
    //Table view functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countToReturn = 0
        if tableView == home_tableView {
            countToReturn = response?.beers?.count ?? 0
        } else if tableView == searchTableView {
            countToReturn = response?.beers?.count ?? 0
        }
        return countToReturn
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()
        if tableView == home_tableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "homeCellid", for: indexPath) as? BeerListHomeCell {
                cell.backgroundColor = UIColor(named: "background_white")
                cell.data = response?.beers![indexPath.row]
                cellToReturn = cell
            }
        } else if tableView == searchTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "homeCellid", for: indexPath) as? BeerListHomeCell {
                cell.backgroundColor = UIColor(named: "background_white")
                cell.data = response?.beers![indexPath.row]
                cellToReturn = cell
            } else {
                cellToReturn = UITableViewCell()
            }
        }
        return cellToReturn
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if tableView == home_tableView {
            home_tableView.deselectRow(at: indexPath, animated: true)
            if let detailVC = self.storyboard?.instantiateViewController(identifier: "BeerDetailVC") as? BeerDetailVC {
                detailVC.beer = response?.beers![indexPath.row]
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        } else if tableView == searchTableView {
            searchTableView.deselectRow(at: indexPath, animated: true)
            if let detailVC = self.storyboard?.instantiateViewController(identifier: "BeerDetailVC") as? BeerDetailVC {
                detailVC.beer = response?.beers![indexPath.row]
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleToReturn
    }
    
    
    //Search bar functions
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchView.isHidden = false
        self.titleToReturn = "Ultimas novedades"
        searchBeers(input: "")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchView.isHidden = true
        response = nil
        self.titleToReturn = "Ultimas novedades"
        self.searchTableView.reloadData()
        self.isEditing = false
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        response = nil
        self.titleToReturn = "Resultados"
        searchBeers(input: searchText.uppercased())
    }
    
    func searchBeers(input : String){
        self.indicatorView.isHidden = false
        
        NetworkManager.shared.obtenerCervezasPorBusqueda(apiToken: Session.shared.api_token!, input: input){
            response, errors in DispatchQueue.main.async {
                self.response = response
                self.indicatorView.isHidden = true
                
                if response?.status == 1 && response?.msg == "Cervezas encontradas" {
                    self.searchTableView.reloadData()
                } else if errors == .badData {
                    self.displayAlert(title: "Error", message: "Ha habido un error")
                    
                } else if errors == .errorConnection {
                    self.displayAlert(title: "Error", message: "El servidor no responde")
                    
                } else if response?.status == 0 {
                    //Si hay algun fallo nos devolvera el error en el response y se le mostrara al usuario mediante un alert
                    self.displayAlert(title: "Error", message: "\(response?.msg ?? "Se ha producido un error")")
                }
            }
        }
        
    }
    
    // Funcion para instanciar alerts.
    func displayAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}
