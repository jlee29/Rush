//
//  TaskSubmitViewController.swift
//  Rush
//
//  Created by Jiwoo Lee on 5/20/17.
//  Copyright © 2017 DolphinDevs. All rights reserved.
//

import UIKit
import Foundation

class TaskSubmitViewController: UIViewController, UITextFieldDelegate, MapViewControllerDelegate {

    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var priceTextField: UITextField!
    
    private var latitude: Double?
    private var longitude: Double?
    
    private var rushModel = RushModel()
    
    @IBAction func submit(_ sender: UIButton) {
        if (allFieldsFilledIn()) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.short
            dateFormatter.timeStyle = DateFormatter.Style.short
            let strDate = dateFormatter.string(from: timePicker.date)
            let price = priceTextField.text!
            let description = descTextField.text!
            rushModel.submitToDatabase(with: description, time: strDate, price: Double(price)!, longitude: self.longitude!, latitude: self.latitude!)
        } else {
            showAlert()
        }
    }
    
    private func allFieldsFilledIn() -> Bool {
        return (descTextField.text! != "" && priceTextField.text! != "" && isValidPrice(priceTextField.text!) != nil
            && self.longitude != nil && self.latitude != nil)
    }
    
    private func isValidPrice(_ price: String) -> Double? {
        if let converted = Double(price) {
            return converted
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descTextField.delegate = self
        priceTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Need To Include All Description", message: "Please fill in all the fields.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in
            print ("pressed ok")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination
        if let mapViewController = destinationViewController as? MapViewController {
            mapViewController.delegate = self
        }
    }
    
    func updatedLocation(with latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        print(latitude)
        print(longitude)
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

