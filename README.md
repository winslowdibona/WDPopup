# WDPopup

Simple, customizable Popup written in Swift, inspired by [CZPicker](https://github.com/chenzeyu/CZPicker)


####Simple Message Popup Example
```swift
let action = WDPopupAction(title: "Ok") { () -> Void in
//do something here
}
let popup = WDPopup(title: "Simple Popup", message: "Popup with a simple message", actions: [action])
popup.present()
```

####Login Popup Example
You can customize the appearance of a text field by setting the WDPopupTextField's appearance properties detailed below. Right before presenting, WDPopup will apply any appearance attributes you configure to the text field. 
````swift
var emailTextField = WDPopupTextField(title: "Email")
emailTextField.keyboardType = .EmailAddress
var passwordTextField = WDPopupTextField(title: "Password")
passwordTextField.secureTextEntry = true
let cancelAction = WDPopupAction(title: "Cancel", completionBlock: nil)
let loginAction = WDPopupAction(title: "Login") { () -> Void in
    print("Email = \(emailTextField.text)")
    print("Password = \(passwordTextField.text)")
}
let popup = WDPopup(title: "Login", textFields: [emailTextField, passwordTextField], actions: [cancelAction, loginAction])
popup.present()
````


##Installation
Just drag and drop WDPopup.swift into your project
