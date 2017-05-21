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
    func submitToDatabase(with location: String, time: String, price: Double) {
        print(location)
        print(time)
        print(price)
        let ref = FIRDatabase.database().reference()
        let defaults = UserDefaults.standard
        let name = defaults.string(forKey: "realName")
        let email = defaults.string(forKey: "email")
        ref.child(encodeFirebaseKey(inputStr: email!)).setValue(name)
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
