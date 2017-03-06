//
//  Book.swift
//  UpTrip
//
//  Created by Luay Suarna on 2/21/17.
//  Copyright © 2017 Luay Suarna. All rights reserved.
//

import Foundation

class Book {
    
    var checkinDate: Date!
    var checkoutDate: Date!
    var roomCount: Int!
    var firstName: String!
    var lastName: String!
    var email: String!
    var phoneNumber: String!
    var country: String!
    
    init(checkinDate: Date!, checkoutDate: Date!, roomCount: Int!, firstName: String!, lastName: String!, email: String!, phoneNumber: String!, country: String!) {
        self.checkinDate = checkinDate
        self.checkoutDate = checkoutDate
        self.roomCount = roomCount
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.country = country
    }
}
