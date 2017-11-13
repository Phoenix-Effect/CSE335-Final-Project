//
//  EarthquakeEntitiy+CoreDataProperties.swift
//  
//
//  Created by Suhail Ghafoor on 11/12/17.
//
//

import Foundation
import CoreData


extension EarthquakeEntitiy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EarthquakeEntitiy> {
        return NSFetchRequest<EarthquakeEntitiy>(entityName: "EarthquakeEntitiy")
    }

    @NSManaged public var depth: Int32
    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var magnitude: Double
    @NSManaged public var status: String?
    @NSManaged public var title: String?
    @NSManaged public var tsunami: Int32
    @NSManaged public var url: String?
    @NSManaged public var detail: String?
    @NSManaged public var time: Int64

}
