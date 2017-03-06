//
//  HotelController.swift
//  UpTrip
//
//  Created by Luay Suarna on 2/16/17.
//  Copyright © 2017 Luay Suarna. All rights reserved.
//

import UIKit
import CoreData

class HotelController: UIViewController {
    
    var hotel: Hotel!
    
    @IBOutlet var hotelLocation: UILabel!
    @IBOutlet var wifiImage: UIImageView!
    @IBOutlet var atmImage: UIImageView!
    @IBOutlet var taxiImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = hotel.name
        hotelLocation.text = hotel.location
        
        if hotel.hasTaxi == false {
            taxiImage.isHidden = true
        }
        if hotel.hasWifi == false {
            wifiImage.isHidden = true
        }
        if hotel.hasAtm == false {
            atmImage.isHidden = true
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
