//
//  HomeController.swift
//  Weather
//
//  Created by Владимир Бондарь on 6/11/18.
//  Copyright © 2018 vbbv. All rights reserved.
//

import UIKit
import CoreLocation
import OpenWeatherSwift

class HomeController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var location: CLLocationCoordinate2D?

    var weather: [Weather] = []
    
    @IBOutlet weak var citiesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstLaunch()

        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        citiesCollectionView.delegate = self
        citiesCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateWeather()

    }
    
    func updateWeather() {
        CoreDataManager.shared.fetch { _, wethArr in
            self.weather = wethArr
            self.citiesCollectionView.reloadData()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.location = locValue
    }
    
    @IBAction func GetLocation(_ sender: Any) {
        guard location != nil else {
            return
        }
        WeatherManager.shared.addCity(coords: location!) { ans, weatherAns in
            guard ans != false else {
                return
            }
            
            let alert = UIAlertController(title: "Location",
    message: "Your location is \((weatherAns.name)!), longitude: \((self.location?.longitude)!), latitude:  \((self.location?.latitude)!)",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "View the weather", style: .default, handler: { _ in
                let controller = self.storyboard!.instantiateViewController(withIdentifier:
                    "DetailViewController") as? DetailViewController
                controller?.weatherData = weatherAns
                self.navigationController!.pushViewController(controller!, animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func firstLaunch() {
        if UserDefaults.isFirstLaunch() {
            WeatherManager.shared.addCity(name: "California") { answer, weatherResponse in
                if answer {
                    CoreDataManager.shared.save(weatherResponse)
                    self.updateWeather()
                }
            }
            WeatherManager.shared.addCity(name: "Oslo") { answer, weatherResponse in
                if answer {
                    CoreDataManager.shared.save(weatherResponse)
                    self.updateWeather()
                }
            }
        }
    }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cityCollectionCell",
                                                      for: indexPath) as? CityCollectionViewCell
        
        cell?.image.image = UIImage(named: WeatherManager.shared.getIcon(cloud: weather[indexPath.row].image!))
        cell?.city.text = weather[indexPath.row].name
        cell?.temp.text = "\(weather[indexPath.row].tempMax!)/\(weather[indexPath.row].tempMin!)°C"
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let controller = storyboard!.instantiateViewController(withIdentifier:
            "DetailViewController") as? DetailViewController
        controller?.weatherData = weather[indexPath.row]
        navigationController!.pushViewController(controller!, animated: true)
    }
}

extension HomeController: CityDelegate {
    func updateCityList() {
        citiesCollectionView.reloadData()
    }
}
