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
        let tap = UITapGestureRecognizer(target: self, action: "tapped")
        view.addGestureRecognizer(tap)
    }

    func tapped() {
        let popupTextField = WDPopupTextField(title: "Test")
        let popupAction = WDPopupAction(title: "Enter") { () -> Void in
            print(popupTextField.textField.text)
        }
        let popup = WDPopup(title: "Test", textFields: [popupTextField], actions: [popupAction])
        popup.present()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

