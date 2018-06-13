//
//  HomeController.swift
//  Weather
//
//  Created by Владимир Бондарь on 6/11/18.
//  Copyright © 2018 vbbv. All rights reserved.
//

import UIKit
import CoreLocation


class HomeController: UIViewController,CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var location: CLLocationCoordinate2D?
    var weathers = WeatherManager.shared.cityArr

    @IBOutlet weak var citiesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

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
        citiesCollectionView.reloadData()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.location = locValue
    }
    
    @IBAction func GetLocation(_ sender: Any) {

    }
}

extension HomeController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cityCollectionCell", for: indexPath) as! CityCollectionViewCell
        
        cell.image.image = UIImage(named: WeatherManager.shared.getIcon(cloud: weathers[indexPath.row].image!))
        cell.city.text = weathers[indexPath.row].name
        cell.temp.text = "\(weathers[indexPath.row].tempMax!)/\(weathers[indexPath.row].tempMin!)°C"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(withIdentifier:
            "DetailViewController") as? DetailViewController
        controller?.weatherData = weathers[indexPath.row]
        navigationController!.pushViewController(controller!, animated: true)
    }
}

extension HomeController: CityDelegate {
    func updateCityList() {
        citiesCollectionView.reloadData()
    }
}
