//
//  DetailViewController.swift
//  Weather
//
//  Created by Владимир Бондарь on 6/12/18.
//  Copyright © 2018 vbbv. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var weatherData: Weather?{
        didSet{
            if cloudImageView == nil {
                return
            }
            cloudImageView.image =  UIImage(named: WeatherManager.shared.getIcon(cloud: weatherData?.image )) ?? #imageLiteral(resourceName: "Clouds")
            tempLabel.text = "\(Int(weatherData?.temp! ?? 0 ))°C"
            windLabel.text = "Wind \n\(weatherData?.wind! ?? 0) m/s"
            rainLabel.text = "Rain chance \(weatherData?.chance! ?? 0)%"
            humidityLabel.text = "Humidity \(weatherData?.humidity! ?? 0)% "
            title = weatherData?.name
            activityIndicator.stopAnimating()
        }
    }
    
    
    @IBOutlet weak var cloudImageView: UIImageView!{
        didSet{
            cloudImageView.image =  UIImage(named: WeatherManager.shared.getIcon(cloud: weatherData?.image) ) ?? #imageLiteral(resourceName: "Clouds")
        }
    }
    @IBOutlet weak var tempLabel: UILabel!{
        didSet {
            tempLabel.text = "\(Int(weatherData?.temp! ?? 0 ))°C"
        }
    }
    @IBOutlet weak var windLabel: UILabel!{
        didSet {
            windLabel.text = "Wind \n\(weatherData?.wind! ?? 0) m/s"
        }
    }
    @IBOutlet weak var rainLabel: UILabel!{
        didSet {
            rainLabel.text = "Rain chance \(weatherData?.chance! ?? 0)%"
        }
    }
    @IBOutlet weak var humidityLabel: UILabel!{
        didSet {
            humidityLabel.text = "Humidity \(weatherData?.humidity! ?? 0)% "
        }
    }
    @IBOutlet weak var statusBarButton: UIBarButtonItem!{
        didSet{
            if WeatherManager.shared.checkCity(weatherData?.name) {
                statusBarButton.image = #imageLiteral(resourceName: "del")
            } else {
                statusBarButton.image = #imageLiteral(resourceName: "Add")
            }
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.items![0].backBarButtonItem?.image = #imageLiteral(resourceName: "Back")
        navigationController?.navigationBar.items![0].title = ""
        title = weatherData?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if weatherData != nil {
            activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func DeleteCity(_ sender: UIBarButtonItem) {
        
    }
}
