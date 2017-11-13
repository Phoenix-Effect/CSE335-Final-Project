//
//  eqDetailViewController.swift
//  Earthquakes
//
//  Created by Suhail Ghafoor on 11/12/17.
//  Copyright © 2017 Suhail Ghafoor. All rights reserved.
//

import UIKit
import MapKit

class eqDetailViewController: UIViewController {
    
    var selectedEq:IndexPath?
    @IBOutlet weak var mapView: MKMapView!
    var eqData:[EarthquakeEntitiy] = earthquakesModel().getEQData()
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var magnitudeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLabels()
        setupMap()
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
    
    //this function sets up the map
    func setupMap(){
        let eq = eqData[(selectedEq?.row)!]
        let lat = eq.lat
        let long = eq.long
        let title = eq.title
        let span = MKCoordinateSpanMake(0.50, 0.50)
        let coord = CLLocationCoordinate2DMake(lat, long)
        let region = MKCoordinateRegion(center: coord, span: span)
        self.mapView.setRegion(region, animated: true)
        let ani = MKPointAnnotation()
        ani.coordinate = coord
        ani.title = title
        self.mapView.addAnnotation(ani)
        self.mapView.selectAnnotation(ani, animated: true)
    }
    
    //sets up labels
    func setupLabels(){
        let eq = eqData[(selectedEq?.row)!]
        locationLabel.text = eq.title
        magnitudeLabel.text = String(eq.magnitude)
        timeLabel.text = makeDateNice(timestamp: eq.time)
    }
    
    //segment control for satellite view
    @IBAction func segmentControl(_ sender: Any) {
        switch ((sender as AnyObject).selectedSegmentIndex) {
        case 0:
            mapView.mapType = MKMapType.standard
        case 1:
            mapView.mapType = MKMapType.satellite
        default:
            mapView.mapType = MKMapType.standard
        }
    }
    
    //date time converter
    //takes in unix timestamp and makes it look nice
    func makeDateNice(timestamp: Int64) -> String{
        let timestamp:Double = Double(timestamp) / 1000
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let strDate = dateFormatter.string(from: date)
        return strDate
        
    }
    

}
