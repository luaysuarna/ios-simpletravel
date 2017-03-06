//
//  AppDelegate.swift
//  UpTrip
//
//  Created by Luay Suarna on 2/14/17.
//  Copyright © 2017 Luay Suarna. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var cities: [City] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 23.0/255.0, green: 50.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        
        if let barFont = UIFont(name: "Avenir-Light", size: 24.0) {
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:barFont]
        }
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        seedData()
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.appcoda.CoreDataDemo" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "UpTrip", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("UpTrip.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            let mOptions = [NSMigratePersistentStoresAutomaticallyOption: true,
                            NSInferMappingModelAutomaticallyOption: true]
            
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: mOptions)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    // Generator data
    func seedData() {
        // Load the restaurants from database
        dropEntity(entity: "City")
        dropEntity(entity: "Hotel")
        
        let cities = fetchRecordsForEntity(entity: "City", inManagedObjectContext: managedObjectContext, predicate: nil) as! [City]
        
        if cities.count == 0 {
            rebuildCities()
            rebuildHotels()
        }
    }
    
    func rebuildCities() {
        var city: City!
        
        let dummyCities: [[Any]] = [
            ["Jogjakarta", "200 + | Near you", "image1"],
            ["Bandung", "400 + | Near you", "image3"],
            ["Papua", "100 + | Near you", "image4"],
            ["Jawa Timur", "230 + | Near you", "image5"],
            ["Banten", "120 + | Near you", "image6"]
        ]
        
        for dummyCity in dummyCities {
            city = createRecordForEntity(entity: "City", inManagedObjectContext: managedObjectContext) as! City
            city.name = dummyCity[0] as! String
            city.city_desc = dummyCity[1] as! String
            city.image = dummyCity[2] as! String
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
                return
            }
        }
    }
    
    func rebuildHotels() {
        let dummyHotels: [[Any]] = [
            ["Jogja Hotel", "Jl. Malioboro Yogyakarta", "image1", 3, 200, true, true, true, "Jogjakarta"],
            ["Keraton Hotel", "Jl. Malioboro Yogyakarta", "image2", 3, 200, true, true, true, "Jogjakarta"],
            ["Malioboro Hotel", "Jl. Malioboro Yogyakarta", "image3", 3, 200, true, true, true, "Jogjakarta"],
            ["Tjimahi Hotel", "Jl. Cimahi Selatan", "image1", 3, 200, true, true, true, "Bandung"],
            ["Alexis Hotel", "Jl. Karapitan", "image2", 3, 200, true, true, true, "Bandung"]
        ]
        
        for dummyHotel in dummyHotels {
            let hotel: Hotel!
            hotel = createRecordForEntity(entity: "Hotel", inManagedObjectContext: self.managedObjectContext) as! Hotel
            
            hotel.name = dummyHotel[0] as! String
            hotel.location = dummyHotel[1] as! String
            hotel.image = dummyHotel[2] as! String
            hotel.rating = NSNumber(value: dummyHotel[3] as! Int)
            hotel.feedback = NSNumber(value: dummyHotel[4] as! Int)
            hotel.hasWifi = dummyHotel[5] as! Bool as NSNumber
            hotel.hasAtm = dummyHotel[6] as! Bool as NSNumber
            hotel.hasTaxi = dummyHotel[7] as! Bool as NSNumber
            
            let predicate = NSPredicate(format: "name == %@", dummyHotel[8] as! String)
            
            var tempCities = fetchRecordsForEntity(entity: "City", inManagedObjectContext: managedObjectContext, predicate: predicate) as! [City]
            if tempCities.count != 0 {
                hotel.city = tempCities[0]
            }
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
                return
            }
        }
    }
    
    func rebuildRoomTypes() {
        let dummyRoomType: [[Any]] = [
            ["Jogja Hotel", "Jl. Malioboro Yogyakarta", "image1", 3, 200, true, true, true, "Jogjakarta"],
            ["Keraton Hotel", "Jl. Malioboro Yogyakarta", "image2", 3, 200, true, true, true, "Jogjakarta"],
            ["Malioboro Hotel", "Jl. Malioboro Yogyakarta", "image3", 3, 200, true, true, true, "Jogjakarta"],
            ["Tjimahi Hotel", "Jl. Cimahi Selatan", "image1", 3, 200, true, true, true, "Bandung"],
            ["Alexis Hotel", "Jl. Karapitan", "image2", 3, 200, true, true, true, "Bandung"]
        ]
        
        for dummyHotel in dummyHotels {
            let hotel: Hotel!
            hotel = createRecordForEntity(entity: "Hotel", inManagedObjectContext: self.managedObjectContext) as! Hotel
            
            hotel.name = dummyHotel[0] as! String
            hotel.location = dummyHotel[1] as! String
            hotel.image = dummyHotel[2] as! String
            hotel.rating = NSNumber(value: dummyHotel[3] as! Int)
            hotel.feedback = NSNumber(value: dummyHotel[4] as! Int)
            hotel.hasWifi = dummyHotel[5] as! Bool as NSNumber
            hotel.hasAtm = dummyHotel[6] as! Bool as NSNumber
            hotel.hasTaxi = dummyHotel[7] as! Bool as NSNumber
            
            let predicate = NSPredicate(format: "name == %@", dummyHotel[8] as! String)
            
            var tempCities = fetchRecordsForEntity(entity: "City", inManagedObjectContext: managedObjectContext, predicate: predicate) as! [City]
            if tempCities.count != 0 {
                hotel.city = tempCities[0]
            }
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
                return
            }
        }
    }
    
    func dropEntity(entity: String) {
        let appDel = UIApplication.shared.delegate as? AppDelegate
        let context = appDel?.managedObjectContext
        let coord = appDel?.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord?.execute(deleteRequest, with: context!)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    func fetchRecordsForEntity(entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext, predicate: NSPredicate!) -> [NSManagedObject] {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        if (predicate != nil) {
            fetchRequest.predicate = predicate
        }
        
        // Helpers
        var result = [NSManagedObject]()
        
        do {
            // Execute Fetch Request
            let records = try managedObjectContext.fetch(fetchRequest)
            
            if let records = records as? [NSManagedObject] {
                result = records
            }
            
        } catch {
            print("Unable to fetch managed objects for entity \(entity).")
        }
        
        return result
    }
    
    func createRecordForEntity(entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> NSManagedObject? {
        // Helpers
        var result: NSManagedObject? = nil
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: managedObjectContext)
        
        if let entityDescription = entityDescription {
            // Create Managed Object
            result = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)
        }
        
        return result
    }
}

