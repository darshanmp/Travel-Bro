//
//  TravelTableViewController.swift
//  TravelBro
//  this is the travel guide related info being displayed here
//  Created by Darshan Masti Prakash,Manjunath Babu on 5/9/16.
//  Copyright © 2016 Darshan Masti Prakash,Manjunath Babu. All rights reserved.
//

import UIKit
import Firebase
//Travel controller to display the guides available for booking and perform related operations on that
class TravelTableViewController: UITableViewController {
    var guide = [Guide]()
    var NoOfItems: Int = 3 //number of guides available
    
    @IBOutlet var myTableView: UITableView!
    override func viewDidLoad() {
        loadSampleGuides() //load the guides from the db
        //commented out for the delay in getting data
       // sleep(10)
       // super.viewDidLoad()
        print("Test if execution has gone before fetching values")
    }
    
    //load the guide related information from the Firebase DB
    func loadSampleGuides() {
        let myRootRef = Firebase(url:"https://crackling-fire-827.firebaseio.com/")
        myRootRef.childByAppendingPath("guides").observeSingleEventOfType(
            FEventType.Value, withBlock: { (snapshot) -> Void in
                for child in snapshot.children {
                    let childSnapshot = snapshot.childSnapshotForPath(child.key)
                    let name = childSnapshot.value["name"] as! String
                    let credits:Int = childSnapshot.value["credits"] as! Int
                    let photo = childSnapshot.value["photo"] as! String
                    let rating: Int = childSnapshot.value["rating"] as! Int
                    //Get Name,Photo, rating, credit related information from the database
                    print("Photo \(photo)")
                    print("Name: \(name)")
                    print("Rating: \(rating)")
                    print("Credits: \(credits)")
                    print("\n")
                    let photo1 = UIImage(named: photo)!
                    let guide1 = Guide(name: name, photo: photo1, rating: rating,credit: String(credits))!
                    self.guide.append(guide1)
                    print("Count= ")
                    print(self.guide.count)
                }
                //made changes here to handle the delay in getting the values
                super.viewDidLoad()
                self.myTableView.reloadData()
                print("server values loaded")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Table view get the no of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //return the table guides count
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guide.count
    }

    //
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "GuideTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GuideTableViewCell
        let guidenew = guide[indexPath.row]
        // Configure the cell...
        cell.nameLabel.text = guidenew.name
        cell.photoLabel.image = guidenew.photo
        cell.creditLabel.text = guidenew.credits
        cell.ratingLabel.rating = guidenew.rating
        return cell
    }
    
    
    @IBAction func hireGuideClick(sender: UIButton) {
        let alert=UIAlertController(title: "Hired the guide successfully!", message: "You are all set!", preferredStyle: UIAlertControllerStyle.Alert);
        //no event handler (just close dialog box)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil));
        presentViewController(alert, animated: true, completion: nil);
    }
}
