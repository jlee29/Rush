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
        let deviceScale = Int(UIScreen.main.scale)
        let width = 200 * deviceScale
        let height = 200 * deviceScale
        let parameters = ["fields": "id, name, email, picture.width(\(width)).height(\(height))"]
        FBSDKGraphRequest(graphPath: "/me", parameters: parameters).start { (connection, result, err) in
            if err != nil {
                print("Failed graph request")
            }
            if let data = result as? [String:Any] {
                print(data["friendrequests"] ?? "no requests found") // lol
                let dict = (data["picture"] as! NSDictionary)
                let data2 = dict["data"] as! NSDictionary
                let url = data2["url"] as! String?
                let defaults = UserDefaults.standard
                defaults.set(data["name"] as! String?, forKey: "realName")
                defaults.set(data["email"] as! String?, forKey: "email")
                defaults.set(url!, forKey: "proPicURL")
                defaults.set("true", forKey: "loggedIn")
                let storyboard = self.storyboard!
                let controller = storyboard.instantiateViewController(withIdentifier: "mainTabBar")
                self.present(controller, animated: true, completion: nil)
            }
        }
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

