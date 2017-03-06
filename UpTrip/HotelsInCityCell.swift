//
//  HotelsInCityCell.swift
//  UpTrip
//
//  Created by Luay Suarna on 2/14/17.
//  Copyright © 2017 Luay Suarna. All rights reserved.
//

import UIKit

class HotelsInCityCell: UITableViewCell {
    
    @IBOutlet var hotelName: UILabel!
    @IBOutlet var hotelLocation: UILabel!
    @IBOutlet var hotelImage: UIImageView!
    @IBOutlet var hotelRateFirst: UIImageView!
    @IBOutlet var hotelRateSecond: UIImageView!
    @IBOutlet var hotelRateThird: UIImageView!
    @IBOutlet var hotelRateFourth: UIImageView!
    @IBOutlet var hotelRateFifth: UIImageView!
    @IBOutlet var mapIcon: UIImageView!
    @IBOutlet var hotelFeedback: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
