//
//  Hotel.swift
//  UpTrip
//
//  Created by Luay Suarna on 2/14/17.
//  Copyright © 2017 Luay Suarna. All rights reserved.
//

import Foundation
import CoreData

class Hotel: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var location: String
    @NSManaged var image: String
    @NSManaged var rating: NSNumber
    @NSManaged var feedback: NSNumber
    @NSManaged var hasWifi: NSNumber
    @NSManaged var hasAtm: NSNumber
    @NSManaged var hasTaxi: NSNumber
    @NSManaged var city: City
    @NSManaged var roomTypes: [RoomType]
}
