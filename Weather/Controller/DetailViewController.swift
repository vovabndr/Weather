//
//  DetailViewController.swift
//  Weather
//
//  Created by Владимир Бондарь on 6/12/18.
//  Copyright © 2018 vbbv. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var weatherData: Weather?
    
    @IBOutlet weak var cloudImageView: UIImageView!{
        didSet{
            cloudImageView.image =  UIImage(named: WeatherManager.shared.getIcon(cloud: (weatherData?.image)!))
        }
    }
    @IBOutlet weak var windLabel: UILabel!{
        didSet {
            windLabel.text = "Wind \n\(weatherData!.wind!) m/s"
        }
    }
    @IBOutlet weak var rainLabel: UILabel!{
        didSet {
            rainLabel.text = "Rain chance \(weatherData!.chance!)%"
        }
    }
    @IBOutlet weak var humidityLabel: UILabel!{
        didSet {
            humidityLabel.text = "Humidity \(weatherData!.humidity!)% "
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.items![0].backBarButtonItem?.image = #imageLiteral(resourceName: "Back")
    navigationController?.navigationBar.items![0].title = ""
    }
    
    @IBAction func DeleteCity(_ sender: UIBarButtonItem) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
    

}
