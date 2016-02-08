# WDPopup

Simple, customizable Popup written in Swift

Inspired by [CZPicker](https://github.com/chenzeyu/CZPicker)


Simple Message Popup Example
```swift
let action = WDPopupAction(title: "Ok") { () -> Void in
//do something here
}
let popup = WDPopup(title: "Simple Popup", message: "Popup with a simple message", actions: [action])
popup.present()
```

You can customize the appearance of a text field by accessing it via the WDPopupTextField's textField property shown below
Login Popup Example 
````swift
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
````


##Installation
Just drag and drop WDPopup.swift into your project
