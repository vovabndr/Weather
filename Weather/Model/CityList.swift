//
//  CityList.swift
//  Weather
//
//  Created by Владимир Бондарь on 6/13/18.
//  Copyright © 2018 vbbv. All rights reserved.
//

import Foundation
import SwiftyJSON

class CityList {
    static let shared = CityList()
    
   private var citiesList: [String]?
    
    func getCities() -> [String] {
        var cities = [String]()
        let url = Bundle.main.url(forResource: "cities_with_countries", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        let json = JSON(data as Any)
        for i in 0..<json.count {
            cities.append(json[i]["city"].string!)
        }
        cities.sort()
        self.citiesList  = cities
        return cities
    }
    
    func getSortedList() -> [[String]] {
        var tmparr = [String]()
        for each in getCities() {
            tmparr.append(String(Array(each)[0]))
        }
        let letters = Array(Set(tmparr)).sorted()

        var sortderArr = Array(repeating: [String]() , count: letters.count)

        for i in 0..<letters.count {
            for city in citiesList!{
                if String(Array(city)[0]) == letters[i]{
                    sortderArr[i].append(city)
                }
            }
        }        
        return sortderArr
    }
    
}
