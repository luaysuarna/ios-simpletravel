//
//  PaymentController.swift
//  UpTrip
//
//  Created by Luay Suarna on 2/20/17.
//  Copyright © 2017 Luay Suarna. All rights reserved.
//

import UIKit
import CoreData

class PaymentController: UIViewController {
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var backgroundView1: UIView!
    @IBOutlet var backgroundView2: UIView!
    @IBOutlet var buttonProcess: UIButton!
    @IBOutlet var roomTypeName: UILabel!
    @IBOutlet var roomTypePrice: UILabel!
    @IBOutlet var bookAmount: UILabel!
    @IBOutlet var totalNight: UILabel!
    @IBOutlet var totalCharge: UILabel!
    
    @IBOutlet var holderName: UITextField!
    @IBOutlet var accountNumber: UITextField!
    @IBOutlet var expDate: UITextField!
    @IBOutlet var cvc: UITextField!
    
    var hotel: Hotel!
    var city: City!
    var book: Book!
    var payment: Payment!
    var roomType: RoomType!
    var totalPrice: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        
        backgroundImage.addSubview(blurEffectView)
        
        backgroundView1.layer.cornerRadius = 5.0
        backgroundView2.layer.cornerRadius = 5.0
        buttonProcess.layer.cornerRadius = 5.0
        
        // Date Process
        let userCalendar = Calendar.current
        let checkday = userCalendar.dateComponents([.day], from: book.checkinDate, to: book.checkoutDate)
        let checkTotalNight = checkday.day! + 1
        
        roomTypeName.text = roomType.name
        roomTypePrice.text = "Rp " + (NSString(format: "%.0f", roomType.price) as String) + " k" as String
        if let stringCount = book.roomCount {
            bookAmount.text = "\(stringCount)"
        }
        
        totalPrice = roomType.price.floatValue * Float(book.roomCount) * (Float(checkTotalNight) as Float?)!
        totalCharge.text = "Rp " + (NSString(format: "%.0f", totalPrice!) as String) + " k" as String
        totalNight.text = "\(checkTotalNight)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func payment(_ sender: UIButtonType) {
        if holderName.text == "" || expDate.text == "" || accountNumber.text == "" || expDate.text == "" || cvc.text == "" {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            let validation = InputValidation()
            
            if !validation.isValidAccountNumber(number: accountNumber.text) {
                let alertController = UIAlertController(title: "Oops", message: "We can't proceed because the account number field is not valid.", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            } else if !validation.isValidExp(number: expDate.text) {
                let alertController = UIAlertController(title: "Oops", message: "We can't proceed because the expire date field is not valid.", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            } else if !validation.isValidCVC(number: cvc.text) {
                let alertController = UIAlertController(title: "Oops", message: "We can't proceed because the cvc field is not valid.", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            } else {
                payment = Payment(creditCard: accountNumber.text, holderName: holderName.text, expDate: expDate.text, cvc: cvc.text)
                
                let alertController = UIAlertController(title: "Payment Success!", message: "Thanks for booked the hotel. You will receive book document in email.", preferredStyle: UIAlertControllerStyle.alert)
                
                let okActionHandler = { (action: UIAlertAction) -> Void in
                    self.performSegue(withIdentifier: "completePayment", sender: nil)
                }
                
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: okActionHandler))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "completePayment" {
            let destinationController = segue.destination as! ListHotelsInCityController
            destinationController.city = city
        }
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
