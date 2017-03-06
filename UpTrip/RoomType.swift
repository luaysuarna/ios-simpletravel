//
//  room.swift
//  UpTrip
//
//  Created by Luay Suarna on 2/17/17.
//  Copyright © 2017 Luay Suarna. All rights reserved.
//

import Foundation
import CoreData

class RoomType: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var bed: String
    @NSManaged var capacity: NSNumber
    @NSManaged var price: NSNumber
    @NSManaged var bathroom: NSNumber
    @NSManaged var hasView: NSNumber
    @NSManaged var hasBreakfast: NSNumber
    @NSManaged var stockRoom: NSNumber
    @NSManaged var imageRoomType: String
    @NSManaged var hotel: Hotel
}
