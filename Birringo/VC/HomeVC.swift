//
//  HomeVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 24/1/22.
//

import UIKit

class HomeVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var home_tableView: UITableView!
    @IBOutlet var home_view: UIView!
    @IBOutlet weak var segmentedControlHome: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        searchBar.delegate = self
        home_tableView.dataSource = self
        home_tableView.delegate = self
    }
    
    private func setupColors(){
        home_tableView.backgroundColor = UIColor(named: "background_white")
        tabBarController?.tabBar.backgroundColor = UIColor(named: "background_views")
        home_view.backgroundColor = UIColor(named: "background_views")
        home_tableView.layer.cornerRadius = 30
        home_tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func onChangedSegmentedControl(_ sender: UISegmentedControl) {
        self.home_tableView.reloadData()
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedIndex = self.segmentedControlHome.selectedSegmentIndex
         switch selectedIndex
         {
         case 0:
             return MockData.datos.count
         case 1:
             return MockData.ale.count
         case 2:
             return MockData.tostada.count
         case 3:
             return MockData.rubia.count
         case 4:
             return MockData.negra.count
         default:
             return 0
         }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "homeCellid", for: indexPath) as? HomeTVCell {
            cell.backgroundColor = UIColor(named: "background_white")
            let selectedIndex = self.segmentedControlHome.selectedSegmentIndex
              switch selectedIndex
              {
              case 0:
                  cell.data = MockData.datos[indexPath.row]
                  return cell
              case 1:
                  cell.data = MockData.ale[indexPath.row]
                  return cell
              case 2:
                  cell.data = MockData.tostada[indexPath.row]
                  return cell
              case 3:
                  cell.data = MockData.rubia[indexPath.row]
                  return cell
              case 4:
                  cell.data = MockData.negra[indexPath.row]
                  return cell
              default:
                  return UITableViewCell()
            }
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let selectedIndex = self.segmentedControlHome.selectedSegmentIndex
         switch selectedIndex
         {
         case 0:
             return "Lager"
         case 1:
             return "Ale"
         case 2:
             return "Tostada"
         case 3:
             return "Rubia"
         case 4:
             return "Negra"
         default:
             return ""
         }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchView.isHidden = false
        searchBar.showsCancelButton = true
        }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isEditing = false
        searchBar.showsCancelButton = false
        searchView.isHidden = true
        searchBar.resignFirstResponder()
    }

}
