//
//  HomeViewController.swift
//  TravelBro
//  Home Controller to go from the Login Page to the next page
//  Created by Darshan Masti Prakash,Manjunath Babu   on 5/9/16.
//  Copyright © 2016 Darshan Masti Prakash,Manjunath Babu . All rights reserved.
//

import Foundation
class HomeController: UIViewController{
    
    @IBOutlet var usernameLabel : UILabel! //username label
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        //check if user is logged in
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            //goto login
            self.performSegueWithIdentifier("goto_login", sender: self)
        } else {
            //username data obtained
            self.usernameLabel.text = prefs.valueForKey("USERNAME") as? String
            //goto SearchAddStoryBoard
             self.performSegueWithIdentifier("goto_searchadd", sender: self)
        }
    }
    //logout has been tapped by the user
    @IBAction func logoutTapped(sender : UIButton) {
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        self.performSegueWithIdentifier("goto_login", sender: self)
    }
    
}