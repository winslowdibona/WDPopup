//
//  ViewController.swift
//  WDPopup
//
//  Created by Winslow DiBona on 2/8/16.
//  Copyright © 2016 winslowD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func simpleMessagePopup(sender: AnyObject) {
        let action = WDPopupAction(title: "Ok") { () -> Void in
            //do something here
        }
        let popup = WDPopup(title: "Simple Popup", message: "Popup with a simple message", actions: [action])
        popup.present()
    }
    
    @IBAction func simpleInputPopup(sender: AnyObject) {
        let firstTextField = WDPopupTextField(title: "First Text Field")
        let secondTextField = WDPopupTextField(title: "Second Text Field")
        let action = WDPopupAction(title: "Ok", textFields: [firstTextField, secondTextField]) { () -> Void in
            print("firstTextField.text = \(firstTextField.textField.text)")
            print("secondTextField.text = \(secondTextField.textField.text)")
        }
        let popup = WDPopup(title: "Simple Input Popup", textFields: [firstTextField, secondTextField], actions: [action])
        popup.present()
    }
    
    @IBAction func loginPopup(sender: AnyObject) {
        let emailTextField = WDPopupTextField(title: "Email")
        emailTextField.textField.keyboardType = .EmailAddress
        let passwordTextField = WDPopupTextField(title: "Password")
        passwordTextField.textField.secureTextEntry = true
        let cancelAction = WDPopupAction(title: "Cancel", completionBlock: nil)
        let loginAction = WDPopupAction(title: "Login") { () -> Void in
            print("Email = \(emailTextField.textField.text)")
            print("Password = \(passwordTextField.textField.text)")
        }
        let popup = WDPopup(title: "Login", textFields: [emailTextField, passwordTextField], actions: [cancelAction, loginAction])
        popup.present()
    }
    
    @IBAction func customizedAppearanceMessagePopup(sender: AnyObject) {
    }
    
    @IBAction func customizedApperanceInputPopup(sender: AnyObject) {
    }
    
    
    
    
    
    
    
    
    

}

