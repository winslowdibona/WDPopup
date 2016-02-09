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
More examples can be found in the Example Project.

####WDPopupTextField Appearance Attributes
All of these have default values but you can customize as you like before presenting the popup
````swift
var backgroundColor : UIColor
var textAlignment : NSTextAlignment
var textColor : UIColor
var textFont : UIFont
var secureTextEntry : Bool
var clearButtonMode : UITextFieldViewMode
var clearsOnBeingEditing : Bool
var keyboardType : UIKeyboardType
var placeholderTextColor : UIColor
var borderWidth : CGFloat
var borderColor : UIColor
var cornerRadius : CGFloat
var masksToBounds : Bool
````
If you want further customization you can set textField properties directly by accessing the UITextField property in WDPopupTextField and telling WDPopupTextField you'll be customizing it manually in the init method. 
````swift
var popupTextField = WDPopupTextField(title : "Text Field", customAppearance : true)
popupTextField.textField.textAlignment = .Center
````


##Installation
Just drag and drop WDPopup.swift into your project
