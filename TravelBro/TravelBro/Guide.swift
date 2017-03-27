//
//  Guide.swift
//  TravelBro
//  This is the Guide class to hold guide related information
//  Created by Darshan Masti Prakash,Manjunath Babu  on 5/9/16.
//  Copyright © 2016 Darshan Masti Prakash,Manjunath Babu. All rights reserved.
//

import Foundation
import UIKit

//hold guide related information
class Guide {
    // MARK: Properties    
    var name: String    //name
    var photo: UIImage? //photo
    var rating: Int     //give rating to the guide
    var credits: String //number of credits needed to buy for the Guide
    init?(name: String, photo: UIImage?, rating: Int, credit: String) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        self.credits = credit
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
}
