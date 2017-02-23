//
//  ViewController.swift
//  WeatherNYC
//
//  Created by Rael Kenny on 2/2/17.
//  Copyright © 2017 Rael Kenny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let apiKey = "93f0aa8885a2f8643392546b0d481c64"
    var zipCode = 10003
    
    
    //output (label, imageView)
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var currentTemp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getWeather() {
        //before we do anything = tell Xcode we are using non-secure transport -> PLIST
        //before - add getWeather to refresh
        
        //create a URL object
        let urlString = "http://api.openweathermap.org/data/2.5/weather?zip=\(zipCode),us&appid=\(apiKey)&units=imperial"
        
        //check that the url is valid before trying to make network call
        guard let url = URL(string: urlString)
            else { return }
        
        
        //create a session (network session) - telling app to start session
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            //get our JSON (data) and turn it into a dictionary
            //check that we have data (since we might not get data back)
            guard let myData:Data = data
                else { return }
            
            //decode raw data back to a dictionary
            guard let json = try? JSONSerialization.jsonObject(with: myData,
                                                            options: []) as! [String: AnyObject]
                else { return }
            
            //get temperature value from JSON
            let temp = Double(json["main"]?["temp"]! as! NSNumber!)
            
            
            //put temp value in our label
            DispatchQueue.main.async {
                self.currentTemp.text = String(format:"%.0f°", temp)
            }
            
        }.resume()
        

        
    }
    
    
    //action (refresh button)
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        getWeather()
    }

    
    

}

