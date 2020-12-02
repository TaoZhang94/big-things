//
//  MasterViewController.swift
//  Big Things
//
//  Created by Zhang, Tao - zhaty039 on 19/11/19.
//  Copyright © 2019 Zhang, Tao - zhaty039. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext? = nil
    
    let dataManager = DataManager.sharedDataManager

    @IBOutlet weak var btnRefresh: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        sleep(4)
        self.navigationController?.hidesBarsOnSwipe = true
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
        -> Int {
            return dataManager.bigThingArr.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "DetailPage"){
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let object = dataManager.bigThingArr[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! BigThingViewController
                controller.bigThingItem = object
                
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }

    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let bigThing = dataManager.bigThingArr[indexPath.row]
            cell.textLabel?.text = bigThing.name
            
            if var imageView = cell.imageView {
                
                imageView.image = bigThing.image
                print(bigThing.image)
            }

            let location = bigThing.location
            cell.detailTextLabel?.text = location
            return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120;
    }
    

    @IBAction func onClick(_ sender: Any) {
        
        //sleep(2)
        tableView.reloadData()
        

    }
    
    @IBAction func aboutOnClick(_ sender: Any) {
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let destinationViewController = mainStoryBoard.instantiateViewController(withIdentifier: "aboutPage") as? UIViewController else {
            
            print("Couldn`t find the controller")
            return
        }
        
        navigationController?.pushViewController(destinationViewController, animated: true)
    }

//        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
//        myTabBarItem1.image = UIImage(named: "Unselected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//        myTabBarItem1.selectedImage = UIImage(named: "Selected ")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//        myTabBarItem1.title = ""
//        myTabBarItem1.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

    
    /*
    func buttonClicked(_ sender: AnyObject?) {
        if sender === btnRefresh {
            // do something
        }
        
        else if sender === btnab {
            // do something
        }
    }
 */
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
