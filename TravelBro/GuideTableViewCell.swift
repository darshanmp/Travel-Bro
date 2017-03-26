//
//  GuideTableViewCell.swift
//  TravelBro
//  This is the TableCell used to display the guides in the application
//  Created by Darshan Masti Prakash,Manjunath Babu   on 5/9/16.
//  Copyright © 2016 Darshan Masti Prakash,Manjunath Babu . All rights reserved.
//

import UIKit

//class for displaying the cell for the guide display page
class GuideTableViewCell: UITableViewCell {
   
    @IBOutlet var photoLabel: UIImageView!  //photo label
    @IBOutlet var nameLabel: UILabel!   //name
    @IBOutlet var ratingLabel: RatingControl! //rating
    @IBOutlet var creditLabel: UILabel! //credit label

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
