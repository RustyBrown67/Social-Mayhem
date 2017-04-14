//
//  SignInVC.swift
//  Social Mayhem
//
//  Created by Russell Brown on 13/04/2017.
//  Copyright © 2017 Russell Brown. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet var emailField: CustomField!
    @IBOutlet var passwordField: CustomField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func facebookBtnTapped(_ sender: UIButton) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Unable to authenticate with FB - \(error!)")
            } else if result?.isCancelled == true {
                print("User cancelled the authentication")
            } else {
                print("FB Authentication Successful")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuthenticate(credential)
            }
        }
        
    }
    
    @IBAction func signinBtnTapped(_ sender: UIButton) {
        
        guard let email = emailField.text, !email.isEmpty else {
                print("The email field needs populating")
                return
        }
        
        guard let pwd = passwordField.text, !pwd.isEmpty else {
            print("The password field needs populating")
            return
        }
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    //signed in without problem
                    print("User authenticated with Firebase via email and pasword")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("Authentication with Firebase and create new user successful")
                        } else {
                            print("Unable to authenticate Firebase with email")
                        }
                    })
                }
            })
    }
    
    func firebaseAuthenticate(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Unable to authenticate with Firebase - \(error!)")
            } else {
                print("Successfully authenticated with Firebase")
            }
        })
    }

}

