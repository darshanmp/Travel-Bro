//
//  LogoutController.swift
//  TravelBro
//
//  Created by Darshan Hosakote  on 5/10/16.
//  Copyright © 2016 Darshan Masti Prakash. All rights reserved.
//

import Foundation
class LogoutController: UIViewController,UITextFieldDelegate {
    override func viewDidLoad() {
           performSegueWithIdentifier("goto_homepage_from_logout", sender: view)
           //super.viewDidLoad()
            // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    