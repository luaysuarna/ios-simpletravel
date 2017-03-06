//
//  ListCityCellTableViewCell.swift
//  UpTrip
//
//  Created by Luay Suarna on 2/14/17.
//  Copyright © 2017 Luay Suarna. All rights reserved.
//

import UIKit

class ListCityCell: UITableViewCell {
    
    @IBOutlet var cityName: UILabel!
    @IBOutlet var cityDescription: UILabel!
    @IBOutlet var cityImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
