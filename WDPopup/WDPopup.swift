import UIKit
import Foundation

enum WDPopupType {
    case Message
    case Input
    case Toast
}

class WDPopup: UIView {
    
    var headerView : UIView!
    var buttonView : UIView!
    var contentView : UIView!
    var containerView : UIView!
    var dimmingView : UIView!
    
    var type : WDPopupType!
    var loginPopup : WDInputPopup!
    var messagePopup : WDMessagePopup!
    
    //customProperties
    var popupBackgroundColor : UIColor = UIColor.whiteColor()
    var dimmingViewAlpha : CGFloat = 0.9
    var highlightColor : UIColor = UIColor.blackColor()
    var textColor : UIColor = UIColor.blackColor()
    
    
    init(title : String, message : String, actions : [WDPopupAction]) {
        super.init(frame: UIScreen.mainScreen().bounds)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceOrientationDidChange:", name: UIDeviceOrientationDidChangeNotification, object: nil)
        type = .Message
        messagePopup = WDMessagePopup(title: title, message: message, actions: actions)
        self.frame = UIScreen.mainScreen().bounds
    }
    
    init(title : String, textFields : [WDPopupTextField], actions : [WDPopupAction]) {
        super.init(frame: UIScreen.mainScreen().bounds)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceOrientationDidChange:", name: UIDeviceOrientationDidChangeNotification, object: nil)
        type = .Input
        loginPopup = WDInputPopup(title: title, actions: actions, textFields: textFields)
        self.frame = UIScreen.mainScreen().bounds
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func present() {
        let window = UIApplication.sharedApplication().windows.first!
        self.frame = window.frame
        window.addSubview(self)
        setupSubviews()
        UIView.animateWithDuration(0.5) { () -> Void in
            self.containerView.center = self.center
        }
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.dimmingView.alpha = 0.9
            }) { (success) -> Void in}
    }
    
    
    
    
    func setupSubviews() {
        if dimmingView == nil {
            buildDimmingView()
            addSubview(dimmingView)
        }
        buildContainerView()
        buildHeaderView()
        buildContentView()
        buildButtonView()
        
        
        let frame1 = containerView.frame
        containerView.frame = CGRectMake(frame1.origin.x,
            frame1.origin.y,
            frame1.size.width,
            self.headerView.frame.size.height + self.contentView.frame.size.height + self.buttonView.frame.size.height)
        containerView.center = CGPointMake(self.center.x, self.center.y + self.frame.size.height)
    }
    
    
    
    
    
    
    func buildHeaderView() {
        let rect = CGRectMake(0.0, 0.0, containerView.frame.size.width, 50.0)
        headerView = UIView(frame: rect)
        headerView.backgroundColor = popupBackgroundColor
        let rect2 = CGRectMake(5.0, 5.0, headerView.frame.size.width - 10.0, headerView.frame.size.height - 10.0)
        let label = UILabel(frame: rect2)
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = .Center
        label.textColor = textColor
        if type == .Message {
            label.text = messagePopup.title
        } else if type == .Input {
            label.text = loginPopup.title
        }
        headerView.addSubview(label)
        containerView.addSubview(headerView)
    }
    
    func buildButtonView() {
        let rect = CGRectMake(0.0, headerView.frame.size.height + contentView.frame.size.height + 2.0, frame.size.width, 50.0)
        buttonView = UIView(frame: rect)
        buttonView.backgroundColor = popupBackgroundColor
        if type == .Message {
            for(var i = 0; i < messagePopup.actions.count; i++) {
                let width = CGFloat(containerView.frame.size.width/CGFloat(messagePopup.actions.count))
                let rect = CGRectMake(CGFloat(i) * width, 0.0, width, buttonView.frame.size.height)
                let button = UIButton(frame: rect)
                button.setTitle(messagePopup.actions[i].title, forState: .Normal)
                button.titleLabel!.frame = CGRectMake(2.0, 2.0, button.frame.size.width - 4.0, button.frame.size.height - 4.0)
                print(button.titleLabel?.frame)
                
                button.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
                button.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
                button.titleLabel!.textColor = textColor
                button.setTitleColor(textColor, forState: .Normal)
                button.titleLabel!.textAlignment = .Center
                buttonView.addSubview(button)
            }
        } else {
            for(var i = 0; i < loginPopup.actions.count; i++) {
                let width = CGFloat(containerView.frame.size.width/CGFloat(loginPopup.actions.count))
                let rect = CGRectMake(CGFloat(i) * width, 0.0, width, buttonView.frame.size.height)
                let button = UIButton(frame: rect)
                button.setTitle(loginPopup.actions[i].title, forState: .Normal)
                button.titleLabel!.frame = CGRectMake(2.0, 2.0, button.frame.size.width - 4.0, button.frame.size.height - 4.0)
                print(button.titleLabel?.frame)
                button.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
                button.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
                button.titleLabel!.textColor = textColor
                button.setTitleColor(textColor, forState: .Normal)
                button.titleLabel!.textAlignment = .Center
                buttonView.addSubview(button)
            }
        }
        containerView.addSubview(buttonView)
    }
    
    func buildContentView() {
        let contentRect = CGRectMake(0.0, headerView.frame.size.height + 1.0, containerView.frame.size.width, 50.0)
        contentView = UIView(frame: contentRect)
        if type == .Message {
            let rect = CGRectMake(5.0, 5.0, contentView.frame.size.width - 10.0, contentView.frame.size.height - 10.0)
            let label = UILabel(frame: rect)
            label.text = messagePopup.title
            label.numberOfLines = 0
            label.textAlignment = .Center
            label.textColor = textColor
            contentView.addSubview(label)
        } else if type == .Input {
            contentView.frame = CGRectMake(0.0, headerView.frame.size.height + 1.0, containerView.frame.size.width, 30.0 + CGFloat(loginPopup.textFields.count * 60))
            for(var i = 0; i < loginPopup.textFields.count; i++) {
                let width = contentView.frame.size.width - 10.0
                let height : CGFloat = 24.0
                let rect = CGRectMake(5.0, 30.0 + (CGFloat(i) * 60.0), width, height)
                loginPopup.textFields[i].textField.frame = rect
                loginPopup.textFields[i].textField.placeholder = loginPopup.textFields[i].title
                loginPopup.textFields[i].textField.backgroundColor = popupBackgroundColor
                
                loginPopup.textFields[i].textField.textColor = textColor
                loginPopup.textFields[i].textField.clearButtonMode = .WhileEditing
                contentView.addSubview(loginPopup.textFields[i].textField)
            }
        }
        contentView.backgroundColor = popupBackgroundColor
        containerView.addSubview(contentView)
    }
    
    
    
    func buildContainerView() {
        let transform = CGAffineTransform(a: 0.8, b: 0, c: 0, d: 0.8, tx: 0, ty: 0)
        let rect = CGRectApplyAffineTransform(frame, transform)
        containerView = UIView(frame: rect)
        containerView.layer.cornerRadius = 6.0
        containerView.clipsToBounds = true
        containerView.center = CGPointMake(center.x, center.y + frame.size.height)
        containerView.backgroundColor = highlightColor
        addSubview(containerView)
    }
    
    func buildDimmingView() {
        let sideLength = frame.size.height > frame.size.width ? frame.size.height : frame.size.width
        dimmingView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        dimmingView.frame = CGRectMake(0, 0, sideLength, sideLength)
        addSubview(dimmingView)
    }
    
    func buttonTapped(sender : UIButton) {
        print("buttonTapped")
        if type == .Message {
            for(var i = 0; i < messagePopup.actions.count; i++) {
                let action = messagePopup.actions[i]
                if action.title == sender.titleLabel?.text {
                    action.selected()
                }
            }
            
        } else if type == .Input {
            for(var i = 0; i < loginPopup.actions.count; i++) {
                let action = loginPopup.actions[i]
                if action.title == sender.titleLabel?.text {
                    action.selected()
                }
            }
        }
        dismiss()
    }
    
    func dismiss() {
        dismissPopup()
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.dimmingView.alpha = 0.0
            }) { (success) -> Void in
                self.removeFromSuperview()
        }
    }
    
    func dismissPopup() {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 3.0, options: .AllowAnimatedContent, animations: { () -> Void in
            self.containerView.center = CGPointMake(self.center.x, self.center.y + self.frame.size.height)
            }, completion: nil)
    }
    
    
    // Handling Rotation
    func deviceOrientationDidChange(notification : NSNotification) {
        self.frame = UIScreen.mainScreen().bounds
        for v in subviews {
            if v.isEqual(dimmingView) { continue }
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                v.alpha = 0.0
                }, completion: { (success) -> Void in
                    v.removeFromSuperview()
                    self.setupSubviews()
                    UIView.animateWithDuration(0.5) { () -> Void in
                        self.containerView.center = self.center
                    }
            })
        }
    }
    
}

struct WDPopupAction {
    
    var title : String!
    var textFields : [WDPopupTextField]!
    var completionBlock : (() -> Void)!
    
    init(title : String, completionBlock : (() -> Void)?) {
        self.title = title
        self.completionBlock = completionBlock
    }
    
    init(title : String, textFields : [WDPopupTextField], completionBlock : (() -> Void)?) {
        self.title = title
        self.textFields = textFields
        self.completionBlock = completionBlock
    }
    
    func selected() {
        if completionBlock != nil {
            if NSThread.isMainThread() {
                completionBlock()
            } else {
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    self.completionBlock
                })
            }
        }
    }
    
}


struct WDPopupTextField {
    
    var title : String!
    var textField : UITextField!
    
    init(title : String) {
        self.title = title
        self.textField = UITextField()
    }
    
}

struct WDMessagePopup {
    var title : String
    var message : String
    var actions : [WDPopupAction]
    
    init(title : String, message : String, actions : [WDPopupAction]) {
        self.title = title
        self.message = message
        self.actions = actions
    }
}

struct WDInputPopup {
    var title : String
    var actions : [WDPopupAction]
    var textFields : [WDPopupTextField]
    
    init(title : String, actions : [WDPopupAction], textFields : [WDPopupTextField]) {
        self.title = title
        self.actions = actions
        self.textFields = textFields
    }
}