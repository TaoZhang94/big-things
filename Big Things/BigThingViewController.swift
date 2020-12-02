//
//  BigThingViewController.swift
//  Big Things
//
//  Created by Zhang, Tao - zhaty039 on 22/11/19.
//  Copyright © 2019 Zhang, Tao - zhaty039. All rights reserved.
//

import UIKit
import MapKit
class BigThingViewController: DetailViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var bigThingImage: UIImageView!
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var textViewDesc: UITextView!
    @IBOutlet weak var locationIM: UIImageView!
    @IBOutlet weak var btnRate: UIButton!
    @IBOutlet weak var ratingPicker: UIPickerView!
    @IBOutlet weak var btnConfirmRating: UIButton!
    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnHome: UIBarButtonItem!
    
    var bigThingInstance:BigThing!
    var ratings = ["1", "2", "3", "4", "5"]
    var finalRating: Int!
    
    var bigThingItem: BigThing? {
        didSet {
        }
    }
    
    let dataManager = DataManager.sharedDataManager
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ratingPicker.delegate = self
        ratingPicker.dataSource = self
        
        //Hide rating components before button on clicked
        self.ratingPicker.isHidden = true
        self.btnConfirmRating.isHidden = true
        self.lbRating.isHidden = true
        
        self.configureView()
        // Do any additional setup after loading the view.
    }
    
    override func configureView() {
        
        if let bigThing = self.bigThingItem{
            
            if let name = lbName{
                name.text = bigThing.name
            }
            
            if let imageView = bigThingImage{
                
                imageView.image = bigThing.image

            }
            
            if let textView = textViewDesc{
                
                textView.text = bigThing.desc
            
            }
            
            if let location = lbLocation{
                
                location.text = bigThing.location
            }
            
            if let locationIcon = locationIM{
                
                locationIcon.image = UIImage(named: "LocationIcon.png")
            }
            
            if let like = btnLike{
                changeButtonImage(type: "like")
                
                
            }
            
            if let rate = btnRate{
                changeButtonImage(type: "rate")
            }
            
            bigThingItem = bigThing
        }
        
        changeButtonImage(type: "like")
        changeButtonImage(type: "rate")

    }
    
    /*
 
     Like button on click function
     
     Set the button image depended on the bigThingItem.isliked
     
     Remove the big thing from array when it has been unliked or add the big thing to array when it has been liked and change the button image
     
 */
    @IBAction func likeOnClick(_ sender: UIButton) {
        
        // If the big thing has been like then cancel the like and remove from favourites
        if ((bigThingItem?.isLiked)!){
            
            let alert = UIAlertController(title: "Cofirm", message: "Unlike this Big Thing?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                self.bigThingItem!.isLiked = false
                self.changeButtonImage(type: "like")
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
            if(dataManager.favourites.contains(bigThingItem!)){
                
                print("dataManager.favouritesArr.contains(bigThingInstance) == true")
                if let index = dataManager.favouritesArr.index(of: bigThingItem!){
                    
                    dataManager.favouritesArr.remove(at: index)
                    bigThingItem!.isLiked = false
                }
            }
            
        }

        else{
            
            bigThingItem!.isLiked = true
            changeButtonImage(type: "like")
            
            if(!dataManager.favouritesArr.contains(bigThingItem!)){
                dataManager.favouritesArr.append(bigThingItem!)
                
                print(dataManager.updateData(bigThingItem: bigThingItem!, target: "favourite", value: true))
            }
        }
    }
    
    
    /*
     
     Para: type
     
     Return: void
     
     Change the button image based on the type
     
 */
    func changeButtonImage(type: String){

            switch type {
                
            //btnLike
            case "like":
                let isLike = bigThingItem!.isLiked
                
                if(isLike){
                    
                   var image = UIImage(named: "Liked-icon.jpg")
                    if let btn = btnLike{
                        btn.setImage(image, for: .normal)
                    }
                }
                
                else{
                    var image = UIImage(named: "Unlike-icon.jpg")
                    
                    if let btn = btnLike{
                        btn.setImage(image, for: .normal)
                    }
                }
                
            //btnRate
            case "rate":
                let isRated = bigThingItem!.isRated
                
                    if (isRated){
                        
                        var image = UIImage(named: "Rated.jpg")
                        
                        if let btn = btnRate{
                            btn.setImage(image, for: .normal)
                        }
                }
                
                    else{
                        
                        var image = UIImage(named: "Rate.jpg")
                        
                        if let btn = btnRate{
                            btn.setImage(image, for: .normal)
                        }
                }
             
            default:
                break;
            }

}
    /*
     
     btnRate on clicked
     
     The user can only rate a big thing for once. The system will show the alert to notify the user.
 */
    @IBAction func btnRateOnClick(_ sender: UIButton) {
        
        //When it hasn`t been rated
        if(!bigThingItem!.isRated){
            let alert = UIAlertController(title: "Rate the Big Thing", message: "Select a rating from the picker to rate this Big Thing and tap the confirm button to submit your rating. Remember, you can only rate a Big Thing for once!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Got it!", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
            //show the picker view to rate
            self.ratingPicker.isHidden = false
            self.btnConfirmRating.isHidden = false
        }
        
        else{
            let alert = UIAlertController(title: "Error", message: "You have already rated the Big Thing!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }

    }
    
    /*
     
     Open the map which shows the location of a big thing for the user when btnLocation on clicked.
 */
    @IBAction func btnLocationOnClick(_ sender: Any) {
        
        let latitude:CLLocationDegrees = Double(bigThingItem!.latitude)!
        let longitude:CLLocationDegrees = Double(bigThingItem!.longitude)!
    
        let distance:CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: distance, longitudinalMeters: distance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placeMark = MKPlacemark(coordinate: coordinates)
        
        let mapItem = MKMapItem(placemark: placeMark)
        
        mapItem.name = bigThingItem!.name
        mapItem.openInMaps(launchOptions: options)
    
        
    }
    
    /*
     when a user confirm the rating, system will send an alert to ask for confirm and send the rating request to API
 */
    
    @IBAction func confirmOnClick(_ sender: Any) {
        
        let alert = UIAlertController(title: "Cofirm", message: "You can only rate the Big Thing for once. Is this your final rating?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if(self.finalRating == nil){
                self.finalRating = 1
            }
            
            self.bigThingItem!.isRated = true
            self.changeButtonImage(type: "rate")
            
            //Hide the rating components and show the average rate of the big thing
            self.ratingPicker.isHidden = true
            self.btnConfirmRating.isHidden = true
            
            self.lbRating.text = self.bigThingItem!.rating + " /5"
  
            //send the rating to API
            var id = self.bigThingItem!.id
            
            var rating = String(self.finalRating)
            self.dataManager.sendRequest(id: id!, rating: rating)
            self.lbRating.isHidden = false
            
            self.dataManager.updateData(bigThingItem: self.bigThingItem!, target: "rated", value: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func homeOnClick(_ sender: Any) {
        
        //Back to home
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ratings.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ratings[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        self.finalRating = Int(ratings[row])
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

