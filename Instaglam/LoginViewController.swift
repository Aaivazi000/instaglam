//
//  LoginViewController.swift
//  Instaglam
//
//  Created by Andriana Aivazians on 10/20/18.
//  Copyright © 2018 Andriana Aivazians. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController {
    
    // UI Outlets & Variable Declarations
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //Log in Button Action
    @IBAction func onlogin(_ sender: Any) {
        //When Log In is clicked do...
        
    }
    
    //Sign Up Button Action
    @IBAction func onsignup(_ sender: Any) {
        //When Sign Up is clicked do...
        
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties to values in text fields
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                if error._code == 202 {
                    //Alert that username is already taken
                    print("Username is alredy taken")
                }
                if (error._code == 200) || (error._code == 201)  {
                    //Alert that something is missing
                    print("Please check the username and password fields. One or more is missing")
                }
            }
            else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
