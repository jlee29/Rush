//
//  ViewController.swift
//  Rush
//
//  Created by Jiwoo Lee on 5/12/17.
//  Copyright © 2017 DolphinDevs. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y:view.frame.height - 75, width: view.frame.width - 32, height: 50)
        loginButton.delegate = self
        
        loginButton.readPermissions = ["email"]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Successfully logged out.")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if (error != nil) {
            print(error)
        }
        print("Succesfully logged in.")
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email, picture"]).start { (connection, result, err) in
            if err != nil {
                print("Failed graph request")
            }
            if let data = result as? [String:Any] {
                let dict = (data["picture"] as! NSDictionary)
                let data2 = dict["data"] as! NSDictionary
                _ = data2["url"] as! String?
                print(data)
//                self.uniqueID = data["id"] as! String?
//                self.realname = data["name"] as! String?
//                self.email = data["email"] as! String?
//                self.updateDatabase(withID: self.uniqueID!, name: self.realname!, email: self.email!)
//                // ns user defaults
//                let defaults = UserDefaults.standard
//                defaults.set(self.uniqueID, forKey: "userID")
//                defaults.set(self.realname, forKey: "realName")
//                defaults.set(self.email, forKey: "email")
//                defaults.set(url!, forKey: "proPic")
                //
                let storyboard = self.storyboard!
                let controller = storyboard.instantiateViewController(withIdentifier: "mainTabBar")
                self.present(controller, animated: true, completion: nil)
            }
        }
        print("worked")
        showEmailAddress()
    }
    
    func showEmailAddress(){
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else { return }
        let credentials = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString)
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("Something went wrong with FB User", error ?? "")
                return
            }
            print("Successfully logged in with user: ", user ?? "")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

