//
//  SearchAddController.swift
//  TravelBro
//  Controller to display the search and the nearby places criteria
//  Created by Darshan Masti Prakash,Manjunath Babu  on 5/9/16.
//  Dropdown reference from BTNavigationDropDown Menu-  PhamBaTho
//  Copyright © 2016 Darshan Masti Prakash, Manjunath Babu. All rights reserved.
//

import Foundation
import Firebase
import BTNavigationDropdownMenu

//Search Controller to get the search results and display the search for nearby places to the user
class SearchAddController: UIViewController {
    @IBOutlet weak var lblCat: UILabel! //label for the category
    @IBOutlet var txtMiles: UITextField! //radius
    var indexSearch :Int = 0
    var Category: String = ""
    var miles :String = ""
    let items = ["Restaurants", "Hill stations", "Nearby Monuments", "Nature", "Wildlife Sanctuary","Carnival Cruises"] //category items
    //control is sent to the searchadddcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: items.first!, items: items)
        self.navigationItem.titleView = menuView
        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
            self!.indexSearch = indexPath
            self!.lblCat.text = self!.items[indexPath]
        }
          func viewDidAppear(animated: Bool) {
               menuView.show()
        }
    }
    
    //Search button click event to process the search query
    @IBAction func btnSearch(sender: UIButton) {

        let f:String = self.txtMiles.text!
        let num = Int(f)
        if(num == nil)
        {
            let alert=UIAlertController(title: "Please enter the correct radius. ex : 600", message: "Incorrect value entered", preferredStyle: UIAlertControllerStyle.Alert);
            //no event handler (just close dialog box)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil));
            presentViewController(alert, animated: true, completion: nil);
        }
        else
        {
        if(f != "")
        {
            miles = self.txtMiles.text!
            if(items.count >= indexSearch)
            {
            Category = items[indexSearch]
            }
            else
            {
            Category = "Restaurants" //assign default criteria
            }
            //assigning the data to be accessed by the next page items
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            prefs.setObject( miles, forKey: "MILES")
            prefs.setObject(Category, forKey: "CATEGORY")
            prefs.synchronize()
            self.performSegueWithIdentifier("gotomapdisplay", sender: self)
            //send these details to perform the search results
        }
        else
        {
            self.txtMiles.text = "Error"
        }
        }
    }
    //button search outlet
    @IBOutlet weak var btnSearch: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}