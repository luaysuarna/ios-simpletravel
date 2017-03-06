//
//  ListHotelsInCityController.swift
//  UpTrip
//
//  Created by Luay Suarna on 2/14/17.
//  Copyright © 2017 Luay Suarna. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class ListHotelsInCityController: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    var hotelsInCity: [Hotel] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var city: City!
    @IBOutlet var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = city.name
        print(city.name)
        let predicate = NSPredicate(format: "city == %@", city)
        hotelsInCity = appDelegate.fetchRecordsForEntity(entity: "Hotel", inManagedObjectContext: appDelegate.managedObjectContext, predicate: predicate) as! [Hotel]
        
        // Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        
        if hotelsInCity.count > 0 {
            geoCoder.geocodeAddressString(hotelsInCity[0].location, completionHandler: { placemarks, error in
                if error != nil {
                    print(error)
                    return
                }
                
                if let placemarks = placemarks {
                    // Get the first placemark
                    let placemark = placemarks[0]
                    
                    // Add annotation
                    let annotation = MKPointAnnotation()
                    annotation.title = self.hotelsInCity[0].name
                    annotation.subtitle = self.hotelsInCity[0].location
                    
                    if let location = placemark.location {
                        annotation.coordinate = location.coordinate
                        
                        // Display the annotation
                        self.mapView.showAnnotations([annotation], animated: true)
                        self.mapView.selectAnnotation(annotation, animated: true)
                    }
                }
            })
        }
        
        // Map customization
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
        // Set the MKMapViewDelegate
        mapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        // Reuse the annotation if possible
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = UIImage(named: hotelsInCity[0].image)
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        // Pin color customization
        annotationView?.pinTintColor = UIColor.orange
        
        return annotationView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hotelsInCity.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hotelInCityIndentifier = "HotelinCityCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: hotelInCityIndentifier, for: indexPath) as! HotelsInCityCell
        
        cell.hotelName.text = hotelsInCity[indexPath.row].name
        cell.hotelLocation.text = hotelsInCity[indexPath.row].location
        cell.hotelFeedback.text = "\(hotelsInCity[indexPath.row].feedback)"
        cell.hotelImage.image = UIImage(named: hotelsInCity[indexPath.row].image)
        cell.hotelImage.layer.cornerRadius = 30.0
        cell.hotelImage.clipsToBounds = true
        
        switch hotelsInCity[indexPath.row].rating {
        case 4:
            cell.hotelRateFifth.isHidden = true
        case 3:
            cell.hotelRateFifth.isHidden = true
            cell.hotelRateFourth.isHidden = true
        case 2:
            cell.hotelRateFifth.isHidden = true
            cell.hotelRateFourth.isHidden = true
            cell.hotelRateThird.isHidden = true
        case 1:
            cell.hotelRateFifth.isHidden = true
            cell.hotelRateFourth.isHidden = true
            cell.hotelRateThird.isHidden = true
            cell.hotelRateSecond.isHidden = true
        default:
            cell.hotelRateFifth.isHidden = true
            cell.hotelRateFourth.isHidden = true
            cell.hotelRateThird.isHidden = true
            cell.hotelRateSecond.isHidden = true
            cell.hotelRateFirst.isHidden = true
        }
        

        // Configure the cell...

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHotel" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RoomTypeController
                destinationController.hotel = hotelsInCity[indexPath.row]
                destinationController.city = city
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
