//
//  BookingController.swift
//  UpTrip
//
//  Created by Luay Suarna on 2/20/17.
//  Copyright © 2017 Luay Suarna. All rights reserved.
//

import UIKit
import CoreData

class BookingController: UITableViewController, UINavigationBarDelegate {
    
    var city: City!
    var hotel: Hotel!
    var roomType: RoomType!
    var book: Book?
    
    @IBOutlet var hotelName: UILabel!
    @IBOutlet var hotelLocation: UILabel!
    @IBOutlet var hotelImage: UIImageView!
    @IBOutlet var backgroundImage: UIImageView!
    
    @IBOutlet var checkIn: UIDatePicker!
    @IBOutlet var checkOut: UIDatePicker!
    @IBOutlet var amountRoom: UITextField!
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var country: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hotelName.text = hotel.name
        hotelLocation.text = hotel.location
        hotelImage.image = UIImage(named: hotel.image)
        backgroundImage.image = UIImage(named: "bali")
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImage.addSubview(blurEffectView)
        
        hotelImage.layer.cornerRadius = 30.0
        hotelImage.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPayment" {
            let destinationController = segue.destination as! PaymentController
            
            destinationController.hotel = hotel
            destinationController.city = city
            destinationController.book = book
            destinationController.roomType = roomType
            
        }
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        switch checkIn.date.compare(checkOut.date) {
        case .orderedDescending:
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because checkout date is earlier then check in date.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
        case .orderedSame:
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because check in date is same with check out date.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
            
        default:
            if amountRoom.text == "" && firstName.text == "" && lastName.text == "" && email.text == "" && phoneNumber.text == "" && country.text == "" {
                let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                
                
            } else {
                let validation = InputValidation()
                amountRoom.text = validation.gsubStringToNumber(string: amountRoom.text)
                let amountRoomInt: Int? = Int(amountRoom.text!)
                
                if amountRoomInt == nil {
                    let alertController = UIAlertController(title: "Oops", message: "We can't proceed because room amount is not valid.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    if !validation.isValidEmail(email: email.text) {
                        let alertController = UIAlertController(title: "Oops", message: "We can't proceed because the email field is not valid.", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                    } else if !validation.isValidPhoneNumber(number: phoneNumber.text) {
                        let alertController = UIAlertController(title: "Oops", message: "We can't proceed because the phone number field is not valid.", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                    } else if amountRoomInt! <= 0 {
                        let alertController = UIAlertController(title: "Oops", message: "We can't proceed because amount room must be greater than 0.", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        book = Book(checkinDate: checkIn.date, checkoutDate: checkOut.date, roomCount: amountRoomInt, firstName: firstName.text, lastName: lastName.text, email: email.text, phoneNumber: phoneNumber.text, country: country.text)
                        
                        self.performSegue(withIdentifier: "showPayment", sender: nil)
                    }
                }
            }
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
