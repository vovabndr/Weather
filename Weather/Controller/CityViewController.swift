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

    var sortArr = CityList.shared.getSortedList()
    var filteredData = [[String]]()
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citySearchBar.delegate = self
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cityCell")
    }
    
    func popUP(text: String){
        let alert = UIAlertController(title: "", message: text, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
                let when = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
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
            filteredData = sortArr.map{$0.filter{$0.lowercased().contains(searchBar.text!.lowercased())}}
            
            for element in filteredData where element.isEmpty{
                filteredData.remove(at: filteredData.index(of: element)!)
            }
            cityTableView.reloadData()
        }
    }
}


extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if inSearchMode {
            return filteredData.count
        }
        return sortArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredData[section].count
        }
        return sortArr[section].count
    }
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if inSearchMode {
            return String(Array(filteredData[section][0])[0])
        }
        return String(Array(sortArr[section][0])[0])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
            let text: String!
            if inSearchMode {
                text = filteredData[indexPath.section][indexPath.row]
            } else {
                text = sortArr[indexPath.section][indexPath.row]
            }
            cell.textLabel?.text = text
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        var city = String()
        if inSearchMode {
            city = filteredData[indexPath.section][indexPath.row]
        } else {
            city = sortArr[indexPath.section][indexPath.row]
        }
        
        WeatherManager.shared.addCity(name: city){ answer in
            if answer == false {
                self.popUP(text: "\(city) is already listed")
            }
            self.performSegue(withIdentifier: "HomeSegue", sender: nil)
            self.cityDelegate?.updateCityList()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.backgroundColor = UIColor(red: 41/255, green: 45/255, blue: 38/255, alpha: 1)
            cell.textLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
}




