//  LoginController.swift
//  TravelBro
//  This is the Login Controller page to validate the user info
//  Created by Darshan Masti Prakash,Manjunath Babu   on 5/9/16.

import UIKit
import Firebase
//Login controller method called to Login to the system
class LoginController: UIViewController,UITextFieldDelegate {
    @IBOutlet var txtuser: UITextField! //enter the user information
    @IBOutlet var txtpwd: UITextField! //enter the password info
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     //login button has been tapped
    @IBAction func signinTapped(sender: UIButton) {
                let uname:NSString = txtuser.text!
                let pwd:NSString = txtpwd.text!
                if ( uname.isEqualToString("") || pwd.isEqualToString("") ) {
                    //password/username is not entered properly
                    let alert=UIAlertController(title: "Sign in Failed!", message: "Please enter the correct Username and Password", preferredStyle: UIAlertControllerStyle.Alert);
                    //no event handler (just close dialog box)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil));
                    presentViewController(alert, animated: true, completion: nil);
                } else {
                    //Check if the user exists in DB
                    let myRootRef = Firebase(url:"https://crackling-fire-827.firebaseio.com/")
                    var loginState: Bool = false
                    myRootRef.childByAppendingPath("users").observeEventType(.Value, withBlock: {
                                        snapshot in
                        for child in snapshot.children {
                            if(child.key == uname)
                            {
                                let childSnapshot = snapshot.childSnapshotForPath(child.key)
                                let pwdOld = childSnapshot.value["Password"] as! String
                                if(pwdOld ==  pwd)
                                {
                                    loginState = true
                                    //success in login
                                }
                                break
                            }
                        }
                        if(loginState ==  true)
                        {
                            //isValidUser = true
                            //valid user information entered
                            NSLog("Login SUCCESS");
                            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                            prefs.setObject(uname, forKey: "USERNAME")
                            prefs.setInteger(1, forKey: "ISLOGGEDIN")
                            prefs.synchronize()
                            self.performSegueWithIdentifier("goto_login_searchadd", sender: self)
                            //self.dismissViewControllerAnimated(true, completion: nil)
                            //control is sent to the searchaddcontroller
                        }
                        else
                        {
                            let alert=UIAlertController(title: "Sign in Failed!", message: "Error occured", preferredStyle: UIAlertControllerStyle.Alert);
                            //no event handler (just close dialog box)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil));
                            self.presentViewController(alert, animated: true, completion: nil);
                        }
                        print("\(snapshot.key) -> \(snapshot.value)")
                    })
                }
    }
    
    
    @IBAction func goto_signup_from_login(sender: UIButton) {
        self.performSegueWithIdentifier("goto_signup_from_login", sender: self)
    }
    @IBAction func ReturnToHomeLogin(sender: UIButton) {
        self.performSegueWithIdentifier("goto_home_login_page", sender: self)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
}
