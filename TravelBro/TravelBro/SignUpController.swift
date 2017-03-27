//
//  SignUpController.swift
//  TravelBro
//  This is the Sign up page to obtain the Sign up for the first time user.
//  Created by Darshan Masti Prakash,Manjunath Babu on 5/9/16.
//  Ref : Dipin Krishna
//  SignupController.swift
//  SwiftLoginScreen

import UIKit
import Firebase

//Sign up controller to get the sign up info to the user
class SignUpController: UIViewController {
    @IBOutlet var txtUname: UITextField! //user name
    @IBOutlet var txtPwd: UITextField! //password
    @IBOutlet var txtConfPwd: UITextField! //confirm password
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
      //self.performSegueWithIdentifier("goto_signup_searchadd", sender:self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gotoLoginFromSignup(sender: UIButton) {
        self.performSegueWithIdentifier("goto_login_from_signup", sender: self)
    }
    //sign up has been tapped by the user
    @IBAction func signupTapped(sender: UIButton) {
                let username:NSString = txtUname.text! as NSString
                let password:NSString = txtPwd.text! as NSString
                let confirm_password:NSString = txtConfPwd.text! as NSString
                if(password == confirm_password)
                {
                    //assign the creation date or timestamp
                    let time = NSDate()
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    let formatteddate = formatter.stringFromDate(time)
                    let id:Int = random()
        
                //Store the latest user logged info to our database system
                let myRootRef = Firebase(url:"https://crackling-fire-827.firebaseio.com/")
                let user = ["Name" : username , "ID" : id, "TimeStamp" : formatteddate, "Password" : password]
                let usersRef = myRootRef.childByAppendingPath("users")
                usersRef.childByAppendingPath( username as String).setValue(user)
                let success: NSInteger = 1
                if(success == 1)
                {
                    NSLog("Login SUCCESS");
                    //assign the user defaults to the NSUserDefaults object
                    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    prefs.setObject(username, forKey: "USERNAME")
                    prefs.setInteger(1, forKey: "ISLOGGEDIN")
                    prefs.synchronize()
                    let alert = UIAlertController(title:"Registration successful",
                                                  message:"You may now login. Thank You!",
                                                  preferredStyle: UIAlertControllerStyle.Alert)
                    let loginAction = UIAlertAction(title:"Login",
                                                    style:UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
                    }
                    alert.addAction(loginAction)
                    //self.performSegueWithIdentifier("goto_signup_searchadd", sender:self)
                    self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
                else{
                    //passwords entered do not match
                    let alert = UIAlertController(title: "Sign up Failed!", message: "Error occured", preferredStyle: UIAlertControllerStyle.Alert);
                    //no event handler (just close dialog box)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil));
                    presentViewController(alert, animated: true, completion: nil);
                }
    }

    @IBAction func gotoHomePage(sender: UIButton) {
        self.performSegueWithIdentifier("goto_homepage_login_from_signup", sender: self)
    }
    //return the text field and stop it fro  being executed when keyboard is being typed
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
}

