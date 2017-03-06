//
//  City.swift
//  UpTrip
//
//  Created by Luay Suarna on 2/14/17.
//  Copyright © 2017 Luay Suarna. All rights reserved.
//

import Foundation
import CoreData

class City: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var city_desc: String
    @NSManaged var image: String
    @NSManaged var hotels: NSSet
}
