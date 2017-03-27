//
//  ViewController.swift
//  TravelBro
//  Main View controller from which the project is loaded and the logins initialized
//  Created by Darshan Masti Prakash,Manjunath Babu   on 4/22/16.
//  Copyright © 2016 Darshan Masti Prakash,Manjunath Babu . All rights reserved.
//  Reference: www.brianjcoleman.com

import UIKit
import Firebase //Firebase import

//View Controller class from which FBLogin Button loads the page
class ViewController: UIViewController, FBSDKLoginButtonDelegate {    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            // Or Show Logout Button
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
             // self.returnUserData()
        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
    }
    
    // Facebook Delegate Methods
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        if ((error) != nil)
        {
            print("Error has occured in connecting to Facebook Login")
            // Process error
        }
        else if result.isCancelled {
            //Handle cancellations
             print("Operation has been cancelled")
            let loginManager = FBSDKLoginManager()
            loginManager.logOut() // this is an instance function
        }
        else {
            self.returnUserData() //success event on facebook login
        }
    }
    //FB logged out button display
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")    //User logged out
        //return to the main screen for login
        let loginManager = FBSDKLoginManager()
        loginManager.logOut() // this is an instance function
    }
    
    @IBAction func newUserClick(sender: UIButton) {
        self.performSegueWithIdentifier("goto_signup_from_Log", sender: self)
    }
    
    @IBAction func existingUserClick(sender: UIButton) {
         self.performSegueWithIdentifier("goto_login_existing", sender: self)
    }
    
    //return user data and store it in Database
    func returnUserData()
    {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email,name,id,gender"])
            graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if ((error) != nil)
            {
                //Process error
                print("Error: \(error)")
            }
            else
            {
                let userName : NSString = result.valueForKey("name") as! NSString
                let userEmail : NSString = result.valueForKey("email") as! NSString
                let gender : NSString = result.valueForKey("gender") as! NSString
                let id : NSString = result.valueForKey("id") as! NSString
                let time = NSDate()
                let formatter = NSDateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                let formatteddate = formatter.stringFromDate(time)
                print("User Name is: \(userName)")
                print("Email is :\(userEmail)")
                print("Gender is :\(gender)")
                print("ID is :\(id)")
                //Store the latest user logged info to our database system
                let myRootRef = Firebase(url:"https://crackling-fire-827.firebaseio.com/")
                let user = ["Name" : userName , "Email" :userEmail, "Gender" : gender , "ID" : id, "TimeStamp" : formatteddate]
                let usersRef = myRootRef.childByAppendingPath("users")
                usersRef.childByAppendingPath(id as String).setValue(user)
                //call the next view i.e the Search Page/Add Review Page
                //Goto the Next page
                self.performSegueWithIdentifier("goto_home_searchadd", sender: self)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

