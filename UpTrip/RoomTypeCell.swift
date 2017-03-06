//
//  RoomTypeCell.swift
//  UpTrip
//
//  Created by Luay Suarna on 2/17/17.
//  Copyright © 2017 Luay Suarna. All rights reserved.
//

import UIKit

class RoomTypeCell: UITableViewCell {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var bed: UILabel!
    @IBOutlet var capacity: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var roomTypeImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
