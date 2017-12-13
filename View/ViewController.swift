//
//  ViewController.swift
//  Earthquakes
//
//  Created by Suhail Ghafoor on 10/30/17.
//  Copyright © 2017 Suhail Ghafoor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var eqMapButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var eqListButton: UIButton!
    
    var eqModelObject:earthquakesModel = earthquakesModel.sharedInstance
    var earthquakes:[EarthquakeEntitiy] = []
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //eqModelObject.updateData()
        earthquakes = eqModelObject.getEQData()
        statusLabel.text = String(earthquakes.count)
        self.spinner.hidesWhenStopped = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func refreshData(_ sender: Any) {
        self.startRefreshing()
        
        // Thank you for the help with this part Marius!
        DispatchQueue.global().async {
            self.eqModelObject.updateData{ (check) in
                if(check){
                    print("finished refreshing");
                }
            }
            DispatchQueue.main.sync {
                self.finishRefreshing()
            }
        }
        

        
    }
    
    func startRefreshing(){
        self.spinner.startAnimating()
        self.eqMapButton.isHidden = true
        self.eqListButton.isHidden = true
    }
    
    func finishRefreshing(){
        self.earthquakes = self.eqModelObject.getEQData()
        self.statusLabel.text = String(self.earthquakes.count)
        self.spinner.stopAnimating()
        self.eqMapButton.isHidden = false
        self.eqListButton.isHidden = false
        print("finished refreshing called")
    }
    
}

