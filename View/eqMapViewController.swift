//
//  eqMapViewController.swift
//  Earthquakes
//
//  Created by Suhail Ghafoor on 11/13/17.
//  Copyright © 2017 Suhail Ghafoor. All rights reserved.
//

import UIKit
import MapKit

class eqMapViewController: UIViewController {
    
    var eqModelObject = earthquakesModel.sharedInstance
    var earthquakes:[EarthquakeEntitiy] = []
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
        loadMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadData(){
        earthquakes = eqModelObject.getEQData()
    }
    
    func loadMap(){
        for i in 0...earthquakes.count - 1{
            let eq = earthquakes[i]
            let lat = eq.lat
            let long = eq.long
            let title = eq.title
            let span = MKCoordinateSpanMake(100.0, 100.0)
            let coord = CLLocationCoordinate2DMake(lat, long)
            let region = MKCoordinateRegion(center: coord, span: span)
            self.mapView.setRegion(region, animated: true)
            let ani = MKPointAnnotation()
            ani.coordinate = coord
            ani.title = title
            ani.subtitle = String(eq.magnitude)
            self.mapView.addAnnotation(ani)
            self.mapView.selectAnnotation(ani, animated: true)
        }
    }
    
    

}
