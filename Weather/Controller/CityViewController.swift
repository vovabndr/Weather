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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        citySearchBar.resignFirstResponder()
        WeatherManager.shared.addCity(name: searchBar.text!)
        
        performSegue(withIdentifier: "HomeSegue", sender: nil)
    }
    

}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        return cell
        
    }
    
    
}
