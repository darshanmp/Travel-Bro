//
//  VisitPlaceController
//  TravelBro
//  Controller to add a review to the place
//  Created by Darshan Masti Prakash,Manjunath Babu   on 5/9/16.
//  Copyright © 2016 Darshan Masti Prakash,Manjunath Babu . All rights reserved.
//

import Foundation
import Firebase
import BTNavigationDropdownMenu

class VisitPlaceController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  
    @IBOutlet var lblRating: RatingControl!
    //control is sent to the searchadddcontroller

    @IBOutlet var photoImageView: UIImageView!  //photo

    @IBOutlet var lblstatus: UILabel! //status of process
    @IBOutlet var txtDesc: UITextField! //description of the place
    @IBOutlet var txtCategory: UITextField! //category of the place chosen
    @IBOutlet var txtPlace: UITextField! //place name
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    
    override func viewDidAppear(animated: Bool) {
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //submit button click event
    @IBAction func submitVisitPlace(sender: UIButton) {
        if(txtPlace.text != "" && txtCategory.text != "" && txtDesc.text != "")
        {
            //store the details in review key in DB
            //Store the latest user logged info to our database system
            let time = NSDate()
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let formatteddate = formatter.stringFromDate(time)
            
            super.viewDidLoad()
            let prefs = NSUserDefaults.standardUserDefaults()
            var uname: String = ""
            if let username = prefs.stringForKey("USERNAME"){
                uname = username
                print("The user has a username: " + username)
            }else{
                uname = "admin"
            }
            
            //Firebase call
            let myRootRef = Firebase(url:"https://crackling-fire-827.firebaseio.com/")
            let placeSend = txtPlace.text!
            let catSend = txtCategory.text!
            let descSend = txtDesc.text!
            let rating = lblRating.rating
            let review = ["Place" : placeSend, "Category" :catSend,
                          "Description" : descSend, "Rating": rating, "UserID" : uname, "TimeStamp" : formatteddate]
            let reviewRef = myRootRef.childByAppendingPath("review")
            let key: Int = random() //generate random key for review id storage
            reviewRef.childByAppendingPath(String(key)).setValue(review)
            
            //display alert window for creation of the review successfully
            let alert=UIAlertController(title: "Succeeded in adding a review!", message: "Success", preferredStyle: UIAlertControllerStyle.Alert);
            //no event handler (just close dialog box)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil));
            presentViewController(alert, animated: true, completion: nil);
            
        }
        else
        {
            lblstatus.text = "Error in the information"
        }
    }
    
    
    //select image from the photo library to pick the images
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
                        let imagePickerController = UIImagePickerController()
                        // Only allow photos to be picked, not taken.
                        imagePickerController.sourceType = .PhotoLibrary
                        // Make sure ViewController is notified when the user picks an image.
                        imagePickerController.delegate = self
                        presentViewController(imagePickerController, animated: true, completion: nil)
    }


    //cancel on the image picker
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
       // Dismiss the picker if the user canceled
    }
    
    //image picker function to load the selected image 
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
    }
}