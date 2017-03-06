//
//  ListCitiesController.swift
//  UpTrip
//
//  Created by Luay Suarna on 2/14/17.
//  Copyright © 2017 Luay Suarna. All rights reserved.
//

import UIKit
import CoreData

class ListCitiesController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var cities: [City] = []
    var city: City!
    var fetchResultController:NSFetchedResultsController<NSFetchRequestResult>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        loadCities()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CityCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListCityCell
    
        cell.cityName.text = cities[indexPath.row].name
        cell.cityDescription.text = cities[indexPath.row].city_desc
        cell.cityImage.image = UIImage(named: cities[indexPath.row].image)

        // Configure the cell...

        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHotelsInCity" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ListHotelsInCityController
                destinationController.city = cities[indexPath.row]
            }
        }
    }
    
    // Code
    
    func loadCities() {
        // Load the restaurants from database
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext {
            
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                cities = fetchResultController.fetchedObjects as! [City]
            } catch {
                print(error)
            }
        }
    }
}
