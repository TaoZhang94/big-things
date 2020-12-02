//
//  DataManager.swift
//  Big Things
//
//  Created by Zhang, Tao - zhaty039 on 20/11/19.
//  Copyright © 2019 Zhang, Tao - zhaty039. All rights reserved.
//

import UIKit
import CoreData
import Foundation
class DataManager {

    var bigThingArr = [BigThing]()
    var imageDic = Dictionary<String, UIImage>()
    
    var favouritesArr = [BigThing]()
    var storedBigThing = [NSManagedObject]()
    static let sharedDataManager = DataManager()
    var isLoaded:Bool = false
    
    init() {
        
        self.loadData()
        self.loadDataFromSystem()
    }
    
    /*
     Load the data from API and store the big thing
 */
    func loadData() {
        
        let session = URLSession.shared
        let url = URL(string: "https://www.partiklezoo.com/bigthings/?")
        
        let task = session.dataTask(with: url! as URL, completionHandler: { data, response, error in
            
            if(error != nil){
                print("Error observed!")
                return
            }

            if let json = try? JSON(data: data!){
                var index = 0
                
                while index < json.count{
                    
                    var object = json[index]
                    
                    let newBigThing = BigThing(name: object["name"].stringValue, status: object["status"].stringValue, year: object["year"].stringValue, rating: object["rating"].stringValue, longitude: object["longitude"].stringValue, location: object["location"].stringValue, description: object["description"].stringValue, update: object["update"].stringValue, latitude: object["latitude"].stringValue, id: object["id"].stringValue, votes: object["votes"].stringValue)
                    
                    let imageURLString = "https://www.partiklezoo.com/bigthings/images/" + object["image"].string!
                    
                    self.addItemToBigThings(newBigThing: newBigThing, imageURL: imageURLString)
                    
                    index += 1
                    
                }
                
            }
            print("Running")
        })
         task.resume()
    }

    /*
     load stored data in the local system
     */
    func loadDataFromSystem() {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BigThings")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            storedBigThing = results as! [NSManagedObject]
            
            if (storedBigThing.count > 0)
            {
                for index in 0 ... storedBigThing.count - 1
                {
                    
                    let binaryData = storedBigThing[index].value(forKey: "image") as! Data
                    let actualImage = UIImage(data: binaryData)
                    let desc = storedBigThing[index].value(forKey: "desc") as! String
                    let name = storedBigThing[index].value(forKey: "name") as! String
                    let id = storedBigThing[index].value(forKey: "id") as! String
                    let favourite = storedBigThing[index].value(forKey: "favourite") as! Bool
                    let year = storedBigThing[index].value(forKey: "year") as! String
                    let latitude = storedBigThing[index].value(forKey: "latitude") as! String
                    let longitude = storedBigThing[index].value(forKey: "longitude") as! String
                    let rating = storedBigThing[index].value(forKey: "rating") as! String
                    let votes = storedBigThing[index].value(forKey: "votes") as! String
                    let rated = storedBigThing[index].value(forKey: "rated") as! Bool
                    let status = storedBigThing[index].value(forKey: "status") as! String
                    let location = storedBigThing[index].value(forKey: "location") as! String
                    let update = storedBigThing[index].value(forKey: "update") as! String

                    let loadedBigThing = BigThing(name: name, status: status, year: year, rating: rating, longitude: longitude, location: location, description: desc, update: update, latitude: latitude, id: id, votes: votes, isLiked: favourite, isRated: rated, image: actualImage!)
                    
                    bigThingArr.append(loadedBigThing)
                    
                }
            }
        }
            
        catch let error as NSError
        {
            print("Could not load. \(error), \(error.userInfo)")
        }
        
   }
  
    //check if a big thing already exists in the array
    func checkIfExits(target: BigThing) -> Int {
        var targetIndex = -1
        
        if (bigThingArr.count > 0) {
            for index in 0 ... bigThingArr.count - 1 {
                if (bigThingArr[index].id.isEqual(target.id)) {
                    targetIndex = index
                }
            }
        }
        
        return targetIndex
    }
    
    /*
     
     Para: id: String, rating: String
     Return: Void
     
     send rating back to the API based on the id and rating
     
 */
    func sendRequest(id: String, rating: String){
        let myUrl = URL(string: "https://www.partiklezoo.com/bigthings/?");
        
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "POST"// Compose a query string
        
        let postString = "action=rate&id=" + id + "&rating=" + rating
        print(postString)
        request.httpBody = postString.data(using: String.Encoding.utf8);
        print(request)
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("response = \(response)")
            
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    
                    print(parseJSON)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    /*
     Para: bigThingItem: BigThing, target: String, value: Bool
     Return: Void
     
     Update a big thing that has been stored in the local system after a big thing has been rated or liked/unliked. Target would be the target attribute and value would be a Bool.
 */
    func updateData(bigThingItem: BigThing, target: String, value: Bool){
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BigThings")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            storedBigThing = results as! [NSManagedObject]
            
            if (storedBigThing.count > 0)
            {
                for index in 0 ... storedBigThing.count - 1
                {
                    let bigThingId = storedBigThing[index].value(forKey: "id")
                    
                    //If we found the big thing in system
                    if(bigThingItem.id == bigThingId as! String){
                        
                        storedBigThing[index].setValue(value, forKey: target)
                        
                        do{
                            try managedContext.save()
                        }
                        catch{
                            print(error)
                        }
                        
                    }
                }
                
            }
            
        }
            
        catch let error as NSError
        {
            print("Error: \(error), \(error.userInfo)")
        }
        
    }
    
    //Store a big thing to the local directory
    func addItemToBigThings(newBigThing: BigThing!, imageURL: String) {
        
        if checkIfExits(target: newBigThing) == -1 {
            
            //get a reference to the managed context
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            //call our loadImage function to create an image object from the url

            newBigThing.image = loadImage(imageURL)
            
            //get an entity reference and ManagedObject
            let entity = NSEntityDescription.entity(forEntityName: "BigThings", in: managedContext)
            let bigThingToAdd = NSManagedObject(entity: entity!, insertInto: managedContext)
            
            //set the data for our new ManagedObject
            bigThingToAdd.setValue(newBigThing.image!.pngData(), forKey: "image")
            print(newBigThing.image)
            bigThingToAdd.setValue(newBigThing.id, forKey: "id")
            bigThingToAdd.setValue(newBigThing.name, forKey: "name")
            bigThingToAdd.setValue(newBigThing.desc, forKey: "desc")
            bigThingToAdd.setValue(newBigThing.latitude, forKey: "latitude")
            bigThingToAdd.setValue(newBigThing.longitude, forKey: "longitude")
            bigThingToAdd.setValue(newBigThing.location, forKey: "location")
            bigThingToAdd.setValue(newBigThing.votes, forKey: "votes")
            bigThingToAdd.setValue(newBigThing.year, forKey: "year")
            bigThingToAdd.setValue(newBigThing.rating, forKey: "rating")
            bigThingToAdd.setValue(newBigThing.update, forKey: "update")
            bigThingToAdd.setValue(newBigThing.status, forKey: "status")
            bigThingToAdd.setValue(newBigThing.isLiked, forKey: "favourite")
            bigThingToAdd.setValue(newBigThing.isRated, forKey: "rated")
            //save managed context
            do {
                try managedContext.save()
            }
            catch let error as NSError
            {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            bigThingArr.append(newBigThing)
            storedBigThing.append(bigThingToAdd)
            
        }
    }
    
    var favourites: [BigThing] {
        get {
            var selectedBigThing = [BigThing]()
            
            if (bigThingArr.count > 0)
            {
                for count in 0...bigThingArr.count - 1
                {
                    if bigThingArr[count].isLiked
                    {
                        selectedBigThing.append(bigThingArr[count])
                    }
                }
            }
            
            return selectedBigThing
        }
    }

    func loadImage(_ imageURL: String) -> UIImage
    {
        var image: UIImage!
        let url = NSURL(string: imageURL)
        if let url = NSURL(string: imageURL)
        {
            if let data = try? Data(contentsOf: url as URL)
            {
                image = UIImage(data: data as Data)
            }
        }
        
        return image!
    }
}
