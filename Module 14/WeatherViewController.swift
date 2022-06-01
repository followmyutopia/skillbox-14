//
//  WeatherViewController.swift
//  Module 14
//
//  Created by Avicus Delacroix on 01.06.2022.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    let apiKey = "dcb8e04ca4134d7a935201055220106"
    var query = "Moscow"
    
    func loadWeather(for: String) {
        AF.request("https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(query)&aqi=no").responseJSON { response in
            guard let data = response.value as? NSDictionary,
                  let current = data["current"] as? NSDictionary,
                  let temperature = current["feelslike_c"] as? Double,
                  let condition = current["condition"] as? NSDictionary,
                  let conditionText = condition["text"] as? String,
                  let url = condition["icon"] as? String
            else { return }
            // save the results to UserDefaults
            Persistence.shared.weatherTemperature = temperature
            Persistence.shared.weatherCondition = conditionText
            Persistence.shared.weatherImage = url
            self.updateView()
            }
    }
    
    func updateView() {
        cityLabel.text = query
        // load the results from UserDefaults
        temperatureLabel.text = "\(String(format: "%.0f", Persistence.shared.weatherTemperature!))°"
        conditionLabel.text = Persistence.shared.weatherCondition
        weatherImage.load(url: URL(string: "https:" + Persistence.shared.weatherImage!)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeather(for: query)
    }

}

extension UIImageView {
    // load the image to UIImageView asynchronously
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
