//
//  favoritesPage.swift
//  Big Things
//
//  Created by Zhang, Tao - zhaty039 on 27/11/19.
//  Copyright © 2019 Zhang, Tao - zhaty039. All rights reserved.
//

import Foundation
import UIKit

class FavoritesPageController: MasterViewController{
    
    @IBOutlet weak var refresh: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView!.reloadData()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.tableView!.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120;
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
        -> Int {
            
            if(dataManager.favourites.count == 0){
                
                return 1
            }
            
            return dataManager.favourites.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

            //set cell when have no big things
            if(dataManager.favourites.count == 0){
                cell.textLabel?.text = "Nothing is here"
                tableView.allowsSelection = false
                cell.detailTextLabel?.isHidden = true
                cell.imageView!.removeFromSuperview()
            }
            
            //otherwise
            else{
                
                let bigThing = dataManager.favourites[indexPath.row]
                
                cell.textLabel?.text = bigThing.name
                
                if let imageView = cell.imageView{
                    
                    imageView.image = bigThing.image
                    
                }
                
                let location = bigThing.location
                cell.detailTextLabel?.text = location
                
            }

            return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Confirm the segue type
        if(segue.identifier == "DetailPage"){
            
            if let indexPath = tableView.indexPathForSelectedRow {
                
                //pass the selected data to the view
                let object = dataManager.favourites[indexPath.row]

                let controller = (segue.destination as! UINavigationController).topViewController as! BigThingViewController
                controller.bigThingItem = object
                
            }
        }
        
    }
    
   @IBAction func refreshOnClick(_ sender: Any) {
        
        sleep(2)
        tableView.reloadData()
        
    }
    
    
}
