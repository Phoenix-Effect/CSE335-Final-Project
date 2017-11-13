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
        cell.time.text = String(earthquake.time)
        cell.magnitude.text = String(earthquake.magnitude)
 
        return cell
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
