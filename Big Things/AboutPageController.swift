//
//  AboutPageController.swift
//  Big Things
//
//  Created by Zhang, Tao - zhaty039 on 28/11/19.
//  Copyright © 2019 Zhang, Tao - zhaty039. All rights reserved.
//

import Foundation
import UIKit

class AboutPageController: UIViewController {
    

    @IBOutlet weak var textViewAbout: UITextView!
    
    override func viewDidLoad() {
        
        textViewAbout.text = "The big things of Australia are a loosely related set of large structures, some of which are novelty architecture and some are sculptures. There are estimated to be over 150 such objects around the country. There are big things in every state and territory in continental Australia. Most big things began as tourist traps found along major roads between destinations. The big things have become something of a cult phenomenon, and are sometimes used as an excuse for a road trip, where many or all big things are visited and used as a backdrop to a group photograph. Many of the big things are considered works of folk art and have been heritage-listed, though others have come under threat of demolition."
    }
}
