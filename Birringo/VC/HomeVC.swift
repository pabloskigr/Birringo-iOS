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
    var arraybusqueda: [beerData] = []
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        searchBar.delegate = self
        home_tableView.dataSource = self
        home_tableView.delegate = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        segmentedControlHome.selectedSegmentIndex = counter
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
    
    @IBAction func onChangedSegmentedControl(_ sender: UISegmentedControl) {
        counter = segmentedControlHome.selectedSegmentIndex
        self.home_tableView.reloadData()
    }
    
    @objc func handlegesture(gesture: UISwipeGestureRecognizer){
        
        if gesture.direction == UISwipeGestureRecognizer.Direction.left && counter < 4 {
            counter += 1
            segmentedControlHome.selectedSegmentIndex = counter
            home_tableView.reloadData()
        }
        if gesture.direction == UISwipeGestureRecognizer.Direction.right && counter > 0 {
            counter -= 1
            segmentedControlHome.selectedSegmentIndex = counter
            home_tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countToReturn = 0
        if tableView == home_tableView {
            let selectedIndex = self.segmentedControlHome.selectedSegmentIndex
             switch selectedIndex
             {
             case 0:
                 countToReturn = MockData.datos.count
             case 1:
                 countToReturn = MockData.ale.count
             case 2:
                 countToReturn = MockData.tostada.count
             case 3:
                 countToReturn = MockData.rubia.count
             case 4:
                 countToReturn = MockData.negra.count
             default:
                 countToReturn = 0
             }
        } else if tableView == searchTableView {
            countToReturn = arraybusqueda.count
        }
        return countToReturn
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()
        if tableView == home_tableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "homeCellid", for: indexPath) as? HomeTVCell {
                cell.backgroundColor = UIColor(named: "background_white")
                let selectedIndex = self.segmentedControlHome.selectedSegmentIndex
                  switch selectedIndex
                  {
                  case 0:
                      cell.data = MockData.datos[indexPath.row]
                      cellToReturn = cell
                  case 1:
                      cell.data = MockData.ale[indexPath.row]
                      cellToReturn = cell
                  case 2:
                      cell.data = MockData.tostada[indexPath.row]
                      cellToReturn = cell
                  case 3:
                      cell.data = MockData.rubia[indexPath.row]
                      cellToReturn = cell
                  case 4:
                      cell.data = MockData.negra[indexPath.row]
                      cellToReturn = cell
                  default:
                      cellToReturn = UITableViewCell()
                }
            }
        } else if tableView == searchTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "homeCellid", for: indexPath) as? HomeTVCell {
                cell.backgroundColor = UIColor(named: "background_white")
                cell.data = arraybusqueda[indexPath.row]
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
                let selectedIndex = self.segmentedControlHome.selectedSegmentIndex
                  switch selectedIndex
                  {
                  case 0:
                      detailVC.beer = MockData.datos[indexPath.row]
                  case 1:
                      detailVC.beer = MockData.ale[indexPath.row]
                  case 2:
                      detailVC.beer = MockData.tostada[indexPath.row]
                  case 3:
                      detailVC.beer = MockData.rubia[indexPath.row]
                  case 4:
                      detailVC.beer = MockData.negra[indexPath.row]
                  default:
                      detailVC.beer = MockData.datos[indexPath.row]
                  }
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        } else if tableView == searchTableView {
            searchTableView.deselectRow(at: indexPath, animated: true)
            if let detailVC = self.storyboard?.instantiateViewController(identifier: "BeerDetailVC") as? BeerDetailVC {
                detailVC.beer = arraybusqueda[indexPath.row]
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var titleToReturn = ""
        if tableView == home_tableView {
            let selectedIndex = self.segmentedControlHome.selectedSegmentIndex
             switch selectedIndex
             {
             case 0:
                 titleToReturn = "Lager"
             case 1:
                 titleToReturn = "Ale"
             case 2:
                 titleToReturn = "Tostada"
             case 3:
                 titleToReturn = "Rubia"
             case 4:
                 titleToReturn = "Negra"
             default:
                 titleToReturn = ""
             }
        } else if tableView == searchTableView {
            titleToReturn = "Resultados"
        }
        return titleToReturn
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchView.isHidden = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchView.isHidden = true
        arraybusqueda = []
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
        arraybusqueda = []
        for busqueda in MockData.datos{
            if busqueda.titulo.uppercased().contains(searchText.uppercased()){
                arraybusqueda.append(busqueda)
            }
        }
        self.searchTableView.reloadData()
        
    }


}
