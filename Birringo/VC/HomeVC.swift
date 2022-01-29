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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColors()
        searchBar.delegate = self
        searchView.isHidden = true
        home_tableView.dataSource = self
        home_tableView.delegate = self
    }
    
    private func setupColors(){
        home_tableView.backgroundColor = UIColor(named: "background_views")
        tabBarController?.tabBar.backgroundColor = UIColor(named: "background_views")
        home_view.backgroundColor = UIColor(named: "background_views")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MockData.datos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "homeCellid", for: indexPath) as? HomeTVCell {
            
            cell.data = MockData.datos[indexPath.row]
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.systemGray3
            cell.selectedBackgroundView = bgColorView
            cell.backgroundColor = UIColor(named: "background_views")
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "Novedades"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        home_tableView.deselectRow(at: indexPath, animated: true)
        if let detailVC = self.storyboard?.instantiateViewController(identifier: "BeerDetailVC") as? BeerDetailVC {
            detailVC.beer = MockData.datos[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
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
