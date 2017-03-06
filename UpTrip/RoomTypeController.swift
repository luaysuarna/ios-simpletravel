//
//  RoomTypeController.swift
//  UpTrip
//
//  Created by Luay Suarna on 2/17/17.
//  Copyright © 2017 Luay Suarna. All rights reserved.
//

import UIKit
import CoreData

class RoomTypeController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var hotelName: UILabel!
    @IBOutlet var hotelLocation: UILabel!
    
    var hotel: Hotel!
    var city: City!
    var roomTypeSelected: RoomType!
    
    var roomTypes: [RoomType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hotelName.text = hotel.name
        hotelLocation.text = hotel.location
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return roomTypes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        roomTypeSelected = roomTypes[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row > 6 {
            hotelName.isHidden = true
            hotelLocation.isHidden = true
        } else {
            hotelName.isHidden = false
            hotelLocation.isHidden = false
        }
        
        let cellIdentifier = "roomTypeCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RoomTypeCell

        cell.name.text = roomTypes[indexPath.row].name
        cell.price.text = "Rp " + (NSString(format: "%.0f", roomTypes[indexPath.row].price) as String) + " k" as String
        cell.bed.text = roomTypes[indexPath.row].bed
        cell.roomTypeImage.image = UIImage(named: roomTypes[indexPath.row].imageRoomType)
        cell.roomTypeImage.layer.cornerRadius = 20.0
        cell.roomTypeImage.clipsToBounds = true
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBooking" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let navController = segue.destination as! UINavigationController
                let destinationController = navController.topViewController as! BookingController
                print(roomTypes[indexPath.row])
                destinationController.hotel = hotel
                destinationController.roomType = roomTypes[indexPath.row]
                destinationController.city = city
            }
        }
    }
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
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
