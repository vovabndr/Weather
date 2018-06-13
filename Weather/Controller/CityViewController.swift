//
//  CityViewController.swift
//  Weather
//
//  Created by Владимир Бондарь on 6/11/18.
//  Copyright © 2018 vbbv. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {

    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var cityTableView: UITableView!
    
    var cityDelegate: CityDelegate?
    
    var cities = CityList.shared.getCities()
    var filteredData = [String]()
    var sortArr = CityList.shared.getSortedList()
    
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citySearchBar.delegate = self
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cityCell")
        
        
    }
    
    
}

extension CityViewController: UISearchBarDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        citySearchBar.resignFirstResponder()
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//            citySearchBar.resignFirstResponder()
//            WeatherManager.shared.addCity(name: searchBar.text!){
//                self.performSegue(withIdentifier: "HomeSegue", sender: nil)
//                self.cityDelegate?.updateCityList()
//        }
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            cityTableView.reloadData()
        } else {
            inSearchMode = true
            filteredData = cities.filter({$0.contains(searchBar.text!)})
            cityTableView.reloadData()
        }
    }
}


extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredData.count
        }
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
            let text: String!
            if inSearchMode {
                text = filteredData[indexPath.row]
            } else {
                text = cities[indexPath.row]
            }
            cell.textLabel?.text = text
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        WeatherManager.shared.addCity(name: cities[indexPath.row]){
            self.performSegue(withIdentifier: "HomeSegue", sender: nil)
            self.cityDelegate?.updateCityList()
        }
    }
}




