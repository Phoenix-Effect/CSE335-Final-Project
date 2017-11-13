//
//  eqTableViewController.swift
//  Earthquakes
//
//  Created by Suhail Ghafoor on 11/12/17.
//  Copyright © 2017 Suhail Ghafoor. All rights reserved.
//

import UIKit

class eqTableViewController: UITableViewController {
    
    @IBOutlet var eqTableView: UITableView!
    var eqModelObject = earthquakesModel()
    var earthquakes:[EarthquakeEntitiy] = []
    
    //returns number of earthquakes
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        earthquakes = eqModelObject.getEQData()
        return earthquakes.count
    }
    
    //makes the cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        earthquakes = eqModelObject.getEQData()
        let cellIdentifier = "earthquakeCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? earthquakeCell else{
            fatalError("Failed")
        }
        
        let earthquake = earthquakes[indexPath.row]
        cell.title.text = earthquake.title
        cell.time.text = makeDateNice(timestamp: earthquake.time)
        cell.magnitude.text = String(earthquake.magnitude)
 
        return cell
    }
    
    //sets cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0;//Choose your custom row height
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        eqTableView.delegate = self
        eqTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
         if(segue.identifier == "eqDetails"){
            let selected:IndexPath = self.tableView.indexPath(for: sender as! UITableViewCell)!
            if let eqDetailController:eqDetailViewController = segue.destination as? eqDetailViewController{
                eqDetailController.selectedEq = selected
            }
        }
    }
    
    
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
