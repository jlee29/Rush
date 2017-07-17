//
//  RushModel.swift
//  Rush
//
//  Created by Jiwoo Lee on 5/20/17.
//  Copyright © 2017 DolphinDevs. All rights reserved.
//

import Foundation
import Firebase

struct RushModel {
    let ref = FIRDatabase.database().reference()
    func submitToDatabase(with desc: String, time: String, price: Double, longitude: Double, latitude: Double) {
        let hashVal = (time + desc + String(price)).hashValue
        let defaults = UserDefaults.standard
        let name = defaults.string(forKey: "realName")
        let email = defaults.string(forKey: "email")
        let userInfo = ref.child(encodeFirebaseKey(inputStr: email!)).child("userinfo")
        let requestInfo = ref.child(encodeFirebaseKey(inputStr: email!)).child("requests").child(String(hashVal))
        
        userInfo.child("name").setValue(name)
        
        requestInfo.child("description").setValue(desc)
        requestInfo.child("time").setValue(time)
        requestInfo.child("price").setValue(price)
        requestInfo.child("longitude").setValue(longitude)
        requestInfo.child("latitude").setValue(latitude)
    }
    func retrieveFromDatabaseForEmails(handler: @escaping ([Order])->(), emails: [String]) { // takes a handler from list of orders to void.
        if(emails.count == 0) {
            print("no emails received")
            exit(EXIT_FAILURE)
        }
        var orderList = [Order]()
        // TODO: the method below is running asynchronously and causing the returned order list to be empty 😞
        for email in emails {
            ref.child(encodeFirebaseKey(inputStr: email)).child("requests").observeSingleEvent(of: .value, with: { (snapshot) in
                for child in snapshot.children.allObjects as! [FIRDataSnapshot] {
                    let value = child.value as? NSDictionary
                    let newOrder = Order(with: value?["description"] as! String,
                                     orderPrice: value?["price"] as! Double,
                                     orderLongitude: value?["longitude"] as! Double,
                                     orderLatitude: value?["latitude"] as! Double)
                    orderList.append(newOrder)
                }
                print("done retrieving data")
                handler(orderList)
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    func retrieveFromDatabaseForSelf(handler: @escaping ([Order])->()) {
        let defaults = UserDefaults.standard
        let email = defaults.string(forKey: "email")
        retrieveFromDatabaseForEmails(handler: handler, emails: [email!])
    }
    func retrieveFromDatabaseForAll(handler: @escaping ([Order])->()) {
        print("cats")
        var orderList = [Order]()
        ref.child("/").observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for child in snapshots {
                    for item in (child.childSnapshot(forPath: "requests").children.allObjects as? [FIRDataSnapshot])!{
                        let value = item.value as? NSDictionary
                        print("value found: \(String(describing: value))")
                        print("longitude found: \(String(describing: value?["longitude"]))")
                        let newOrder = Order(with: value?["description"] as! String,
                                             orderPrice: value?["price"] as! Double,
                                             orderLongitude: value?["longitude"] as! Double,
                                             orderLatitude: value?["latitude"] as! Double)
                        orderList.append(newOrder)
                    }
                }
            }
            print("sent data")
            handler(orderList)
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        print("completed execution")
    }
    

    func encodeFirebaseKey(inputStr: String) -> String {
        var newStr = inputStr
        newStr = inputStr.replacingOccurrences(of: ".", with: "😍")
        newStr = newStr.replacingOccurrences(of: "$", with: "🙄")
        newStr = newStr.replacingOccurrences(of: "[", with: "🙈")
        newStr = newStr.replacingOccurrences(of: "]", with: "😉")
        newStr = newStr.replacingOccurrences(of: "#", with: "😒")
        newStr = newStr.replacingOccurrences(of: "/", with: "😂")
        return newStr
    }
    func decodeFirebaseKey(inputStr: String) -> String {
        var newStr = inputStr
        newStr = inputStr.replacingOccurrences(of: "😍", with: ".")
        newStr = newStr.replacingOccurrences(of: "🙄", with: "$")
        newStr = newStr.replacingOccurrences(of: "🙈", with: "[")
        newStr = newStr.replacingOccurrences(of: "😉", with: "]")
        newStr = newStr.replacingOccurrences(of: "😒", with: "#")
        newStr = newStr.replacingOccurrences(of: "😂", with: "/")
        return newStr
    }
}
