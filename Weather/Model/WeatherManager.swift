//
//  CityManager.swift
//  Weather
//
//  Created by Владимир Бондарь on 6/12/18.
//  Copyright © 2018 vbbv. All rights reserved.
//

import Foundation
import OpenWeatherSwift


class WeatherManager {
    static let shared = WeatherManager()
    
    var cityArr = [Weather]()
    
    var newApi = OpenWeatherSwift(apiKey: "df1b232f2cf2310fbe46e6ae43856c37",
                                  temperatureFormat: .Celsius)
    
    func addCity(name: String, handler: @escaping (Bool)->Void) {
        if !checkCity(name){
            handler(false)
            return
        }
        newApi.currentWeatherByCity(name: name) { jsonAnswer in
            if jsonAnswer["cod"] == "404" {
                return
            }
            self.cityArr.append(Weather(json: jsonAnswer))
            handler(true)
        }
    }
    
    func checkCity(_ name: String?)->Bool {
        for city in cityArr where city.name == name{
            return false
        }
        return true
    }
    
    func getIcon( cloud: String?) -> String {
        switch cloud {
        case  "01d" , "01n":
            return "Clear"
        case "02d" , "02n" , "50d", "50n", "04d" ,"04n":
            return "Few"
            
        case "03d" , "03n" , "13d" ,"13n" :
            return "Clouds"
            
        case "09d" , "09n" , "10d" , "10n":
            return "Rain"
            
        case "11d" , "11n":
            return "Thunderstorm"
        default:
            return ""
        }
    }
    
}
