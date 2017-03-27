//
//  IndividualPinDisplayController.swift
//  TravelBro
//  Controller to display each pin on the map search results
//  Created by Darshan Masti Prakash,Manjunath Babu   on 5/9/16.
//  Copyright © 2016 Darshan Masti Prakash,Manjunath Babu . All rights reserved.
//

import Foundation

class IndividualPinDisplayController: UIViewController{
    @IBOutlet var lblname: UILabel! //name of the place
    @IBOutlet var lblphone: UILabel! //phone number of the place
    @IBOutlet var lblurl: UILabel! //url of the place
    
    @IBOutlet var btnGetGuide: UIButton! //get the guide button info
    
    @IBAction func btnClick(sender: UIButton) {        
         self.performSegueWithIdentifier("goto_guidepage", sender: self)
        //redirect to the next page where individual results are displayed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //assign the title, subtitle and phone no to the userdefaults
        if let Title = defaults.objectForKey("Title") as? String {
            self.lblname.text = defaults.objectForKey("Title") as? String
            print(Title)
        }
        if let SubTitle = defaults.objectForKey("Subtitle") as? String {
            self.lblurl.text = defaults.objectForKey("Subtitle") as? String
            print(SubTitle)
        }
        if let PhoneNo = defaults.objectForKey("PhoneNo") as? String {
            self.lblphone.text = defaults.objectForKey("PhoneNo") as? String
            print(PhoneNo)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}