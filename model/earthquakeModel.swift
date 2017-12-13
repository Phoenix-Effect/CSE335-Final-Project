//
//  earthquakeModel.swift
//  Earthquakes
//
//  Created by Suhail Ghafoor on 11/12/17.
//  Copyright © 2017 Suhail Ghafoor. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SwiftyJSON

final class earthquakesModel{
    
    var earthquakesArray:[EarthquakeEntitiy] = []
    
    
    //implementing singleton to not have too many accesses to coredata
    static let sharedInstance: earthquakesModel = {
        let instance = earthquakesModel()
        instance.refreshEarthquake()
        return instance
    }()
    private init(){}
    
    //get data
    func getEQData() -> [EarthquakeEntitiy] {
        print("getData called")
        if(earthquakesArray.count == 0){
            do{
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                earthquakesArray  = try context.fetch(EarthquakeEntitiy.fetchRequest())
                print("accessed coreData")
            } catch{
                print("fetching from core data failed")
            }
        }
        
        return earthquakesArray
    }
    
    //loads from coreData to local array
    func refreshEarthquake(){
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            earthquakesArray = try context.fetch(EarthquakeEntitiy.fetchRequest())
        } catch{
            print("Couldn't find from core data")
        }
    }
    
    //updates the coredata with new stuff
    func updateData(completionHandler:@escaping(Bool)->()){
        print("going into fetch")
        let mOC = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_day.geojson")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                //convert it to JSON
                let json = JSON(data)
                
                //clear previously stored data
                self.clearAll()

                //loop over earthquakes
                for (_,subJson):(String, JSON) in json["features"] {
                    let eq = EarthquakeEntitiy(context: mOC)
                    
                    //put it into core data
                    eq.title = subJson["properties"]["place"].stringValue
                    eq.depth = subJson["geometry"]["coordinates"][2].int32Value
                    eq.detail = subJson["properties"]["detail"].stringValue
                    eq.long = subJson["geometry"]["coordinates"][0].doubleValue
                    eq.lat = subJson["geometry"]["coordinates"][1].doubleValue
                    eq.magnitude = subJson["properties"]["mag"].doubleValue
                    eq.status = subJson["properties"]["status"].stringValue
                    eq.tsunami = subJson["properties"]["tsunami"].int32Value
                    eq.url = subJson["properties"]["url"].stringValue
                    eq.time = subJson["properties"]["time"].int64Value
                    
                    //save
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                }
            }
            print("data fetched")
            self.refreshEarthquake()
            completionHandler(true)
        }).resume()
        
    }
    
    //clears all stored eq
    func clearAll(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EarthquakeEntitiy")
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // whole fetchRequest object is removed from the managed object context
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
        }
        catch _ as NSError {
            // Handle error
        }

    }
    
}
