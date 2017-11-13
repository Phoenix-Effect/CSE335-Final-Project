//
//  ViewController.swift
//  Earthquakes
//
//  Created by Suhail Ghafoor on 10/30/17.
//  Copyright © 2017 Suhail Ghafoor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    
    var eqModelObject = earthquakesModel()
    var earthquakes:[EarthquakeEntitiy] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //eqModelObject.updateData()
        print("JSON fetched")
        earthquakes = eqModelObject.getEQData()
        statusLabel.text = String(earthquakes.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

