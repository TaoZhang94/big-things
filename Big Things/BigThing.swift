//
//  BigThing.swift
//  Big Things
//
//  Created by Zhang, Tao - zhaty039 on 20/11/19.
//  Copyright © 2019 Zhang, Tao - zhaty039. All rights reserved.
//

import Foundation
import UIKit
class BigThing: NSObject{
    
    var name: String! = ""
    var status: String! = ""
    var rating: String! = ""
    var longitude: String! = ""
    var location: String! = ""
    var desc: String! = ""
    var update: String! = ""
    var latitude: String! = ""
    var id: String! = ""
    var votes: String! = ""
    var year:String! = ""
    var isLiked:Bool = false
    var isRated:Bool = false
    var attributArr = [String]()
    var image: UIImage?

    override init() {
        
    }
    
    init(name: String, status: String, year: String, rating: String, longitude: String, location: String, description: String, update: String, latitude: String, id: String, votes: String) {
        
        self.name = name
        self.status = status
        self.year = year
        self.rating = rating
        self.longitude = longitude
        self.location = location
        self.desc = description
        self.update = update
        self.latitude = latitude
        self.id = id
        self.votes = votes
        
    }
    
    init(name: String, status: String, year: String, rating: String, longitude: String, location: String, description: String, update: String, latitude: String, id: String, votes: String, isLiked: Bool, isRated: Bool, image: UIImage) {
        
        self.name = name
        self.status = status
        self.year = year
        self.rating = rating
        self.longitude = longitude
        self.location = location
        self.desc = description
        self.update = update
        self.latitude = latitude
        self.id = id
        self.votes = votes
        self.isLiked = isLiked
        self.isRated = isRated
        self.image = image
        
    }
    
    func setImage(bigThingImage: UIImage){
        
        self.image = bigThingImage
        
    }
}
