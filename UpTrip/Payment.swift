//
//  Payment.swift
//  UpTrip
//
//  Created by Luay Suarna on 2/23/17.
//  Copyright © 2017 Luay Suarna. All rights reserved.
//

import Foundation

class Payment {
    
    var creditCard: String!
    var holderName: String!
    var expDate: String!
    var cvc: String!
    
    init(creditCard: String!, holderName: String!, expDate: String!, cvc: String!) {
        self.creditCard = creditCard
        self.holderName = holderName
        self.expDate = expDate
        self.cvc = cvc
    }
    
}
