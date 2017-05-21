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
    func submitToDatabase(with desc: String, time: String, price: Double) {
        let hashVal = (time + desc + String(price)).hashValue
        let ref = FIRDatabase.database().reference()
        let defaults = UserDefaults.standard
        let name = defaults.string(forKey: "realName")
        let email = defaults.string(forKey: "email")
        let userInfo = ref.child(encodeFirebaseKey(inputStr: email!)).child("userinfo")
        let requestInfo = ref.child(encodeFirebaseKey(inputStr: email!)).child("requests").child(String(hashVal))
        
        userInfo.child("name").setValue(name)
        
        requestInfo.child("description").setValue(desc)
        requestInfo.child("time").setValue(time)
        requestInfo.child("price").setValue(price)
        
        
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
}
