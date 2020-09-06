//
//  CustomAlert.swift
//
//  Created by GP on 15/05/17.
//  Copyright © 2017. All rights reserved.
//

import UIKit

class CustomAlert: UIView {
    
    typealias CustomAlertButtonActionCallBack = (Int) -> Void
    var customAlertButtonActionCallBack:CustomAlertButtonActionCallBack?
    
    static let sharedInstance = CustomAlert()
    var alertWindow:UIWindow?
    let titleLabel          = UILabel()
    let messageLabel        = UILabel()
    let containerView       = UIView()
    var yOffset:CGFloat     = 0.0
    var visible:Bool        = false
    var showAgain:Bool      = false
    let divider             = UIView()
    let overlayView         = UIView()
    var isInitalized:Bool   = false
    let imageView           = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    func initalize() {
        self.alertWindow = UIApplication.shared.keyWindow
        self.frame = (self.alertWindow?.bounds)!
        self.alertWindow?.addSubview(self)
        self.alpha = 0.0
        
        overlayView.frame = (self.alertWindow?.bounds)!
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.addSubview(self.overlayView)
        
        var xOffset:CGFloat = 38.2
        
        if Device.IS_IPAD{
            xOffset  = 202.0
        }
        
        containerView.frame = CGRect(x:xOffset, y:0.0, width:self.frame.size.width-2*xOffset, height:0.0)
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 8.0
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 2.0
        containerView.layer.shadowOpacity = 0.2
        self.addSubview(containerView)
        
        titleLabel.textColor = UIColor(red:80.0/255.0,green:80.0/255.0,blue:80.0/255.0,alpha:1.0)
        titleLabel.numberOfLines = 100
        titleLabel.font = UIFont(name:Font.regular, size:22.0)
        titleLabel.textAlignment = .center
        containerView.addSubview(titleLabel)
        
        messageLabel.textColor = UIColor(red:80.0/255.0,green:80.0/255.0,blue:80.0/255.0,alpha:1.0)
        messageLabel.numberOfLines = 100
        messageLabel.font = UIFont(name:Font.regular, size:14.0)
        messageLabel.textAlignment = .center
        containerView.addSubview(messageLabel)
        
        divider.backgroundColor = UIColor(red:221.0/255.0, green:221.0/255.0, blue:221.0/255.0, alpha:1.0)
        containerView.addSubview(divider)
        
        containerView.addSubview(imageView)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func show(title:String?, message:String?, buttons:[String], completion:((Int)-> Void)!){
        
        if !self.isInitalized {
            self.initalize()
            self.isInitalized = true
        }
        
        for subView in self.containerView.subviews{
            if subView is UIButton {
                subView.removeFromSuperview()
            }
        }
        
        self.alertWindow?.addSubview(self)
        self.customAlertButtonActionCallBack = completion
        
        let width:CGFloat = self.containerView.frame.size.width
        
        yOffset = 21.0
        
        
        self.imageView.alpha = 0.0
        self.titleLabel.text = ""
        self.messageLabel.text = ""
        
        if title != nil && title?.trimmingCharacters(in:.whitespaces).count != 0 {
            self.titleLabel.frame = CGRect(x:18.0, y:yOffset, width:width-36.0, height:20.0)
            let constraintRect:CGSize = CGSize(width:self.titleLabel.frame.size.width, height:CGFloat(MAXFLOAT))
            let textSize:CGRect = title!.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.titleLabel.font!], context: nil)
            self.titleLabel.text = title
            self.titleLabel.frame = CGRect(x:18.0, y:yOffset, width:width-36.0, height:textSize.size.height)
            
            yOffset += (textSize.height+20.0)
        }
        
        if message != nil && message?.trimmingCharacters(in:.whitespaces).count != 0 {
            self.messageLabel.frame = CGRect(x:18.0, y:yOffset, width:width-36.0, height:20.0)
            let constraintRect:CGSize = CGSize(width:self.messageLabel.frame.size.width, height:CGFloat(MAXFLOAT))
            let textSize:CGRect = message!.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.messageLabel.font!], context: nil)
            self.messageLabel.text = message
            self.messageLabel.frame = CGRect(x:18.0, y:yOffset, width:width-36.0, height:textSize.size.height)
            
            yOffset += (textSize.height+20.0)
        }
        
        divider.alpha=1.0;
        divider.frame = CGRect(x:0.0, y:yOffset, width:width, height:1.0);
        
        let buttonHeight:CGFloat = 50.0
        if buttons.count == 1 {
            
            let optionButton:UIButton = UIButton()
            optionButton.frame = CGRect(x:0, y:yOffset, width:width, height:buttonHeight)
            optionButton.setTitle(buttons[0], for: .normal)
            optionButton.tag = 0
            optionButton.setTitleColor(Color.themeColor, for: .normal)
            optionButton.setTitleColor(UIColor.gray, for: .highlighted)
            optionButton.titleLabel?.font = UIFont(name:Font.regular, size:18.0)
            optionButton.addTarget(self, action: #selector(self.buttonAction(sender:)), for: .touchUpInside)
            self.containerView.addSubview(optionButton)
            
            yOffset += buttonHeight
        }
        else if buttons.count == 2 {
            var xOffset:CGFloat = 0.0
            var index:Int = 0
            let buttonWidth:CGFloat = width/2.0
            
            for buttonTitle in buttons{
                let optionButton:UIButton = UIButton()
                optionButton.frame = CGRect(x:xOffset, y:yOffset, width:buttonWidth, height:buttonHeight)
                optionButton.setTitle(buttonTitle, for: .normal)
                optionButton.tag = index
                optionButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
                optionButton.setTitleColor(UIColor.gray, for: .highlighted)
                optionButton.titleLabel?.font = UIFont(name:Font.regular, size:18.0)
                optionButton.addTarget(self, action: #selector(self.buttonAction(sender:)), for: .touchUpInside)
                self.containerView.addSubview(optionButton)
                
                if index == 0 {
                    let divider = UIView()
                    divider.backgroundColor = UIColor(red:221.0/255.0, green:221.0/255.0, blue:221.0/255.0, alpha:1.0)
                    divider.frame = CGRect(x:buttonWidth-1.0, y:0, width:1.0, height:buttonHeight)
                    optionButton.addSubview(divider)
                }
                
                xOffset += buttonWidth;
                index = index+1;
            }
            
            yOffset += buttonHeight
            
        }
        
        let xOffset:CGFloat = self.containerView.frame.origin.x
        
        self.containerView.frame = CGRect(x:xOffset, y:self.frame.size.height, width:width, height:yOffset)
        self.alertWindow?.bringSubviewToFront(self)
        self.showAgain = true
        
        self.perform(#selector(self.showAlert), with: nil, afterDelay: 0.5)
        
        if self.visible {
            return
        }
        
        self.visible = true
        
        self.containerView.frame = CGRect(x:xOffset, y:(self.frame.size.height-self.containerView.frame.size.height)/2.0, width:width, height:yOffset)
        self.containerView.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1.0
            self.containerView.transform = CGAffineTransform.identity
        }
    }
    
    
    func show(title:String?, message:String?,image:UIImage, imageBGColor:UIColor,contentMode:UIView.ContentMode, buttons:[String], completion:((Int)-> Void)!){
        
        if !self.isInitalized {
            self.initalize()
            self.isInitalized = true
        }
        
        for subView in self.containerView.subviews{
            if subView is UIButton {
                subView.removeFromSuperview()
            }
        }
        
        self.alertWindow?.addSubview(self)
        self.customAlertButtonActionCallBack = completion
        
        let width:CGFloat = self.containerView.frame.size.width
        
        yOffset = 21.0
        
        
        self.imageView.backgroundColor = imageBGColor;
        self.imageView.frame = CGRect(x:0, y:0, width:width, height:160.0)
        self.imageView.image = image
        self.imageView.contentMode   = contentMode
        self.imageView.alpha = 1.0
        self.titleLabel.text = ""
        self.messageLabel.text = ""
        
        yOffset += self.imageView.frame.size.height
        
        if title != nil && title?.trimmingCharacters(in:.whitespaces).count != 0 {
            self.titleLabel.frame = CGRect(x:14.0, y:yOffset, width:width-28.0, height:20.0)
            let constraintRect:CGSize = CGSize(width:self.titleLabel.frame.size.width, height:CGFloat(MAXFLOAT))
            let textSize:CGRect = title!.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.titleLabel.font!], context: nil)
            self.titleLabel.text = title
            self.titleLabel.frame = CGRect(x:14.0, y:yOffset, width:width-28.0, height:textSize.size.height)
            
            yOffset += (textSize.height+20.0)
        }
        
        if message != nil && message?.trimmingCharacters(in:.whitespaces).count != 0 {
            self.messageLabel.frame = CGRect(x:14.0, y:yOffset, width:width-28.0, height:20.0)
            let constraintRect:CGSize = CGSize(width:self.messageLabel.frame.size.width, height:CGFloat(MAXFLOAT))
            let textSize:CGRect = message!.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.messageLabel.font!], context: nil)
            self.messageLabel.text = message
            self.messageLabel.frame = CGRect(x:14.0, y:yOffset, width:width-28.0, height:textSize.size.height)
            
            yOffset += (textSize.height+20.0)
        }
        
        divider.alpha=1.0;
        divider.frame = CGRect(x:0.0, y:yOffset, width:width, height:1.0);
        
        let buttonHeight:CGFloat = 50.0
        if buttons.count == 1 {
            
            let optionButton:UIButton = UIButton()
            optionButton.frame = CGRect(x:0, y:yOffset, width:width, height:buttonHeight)
            optionButton.setTitle(buttons[0], for: .normal)
            optionButton.tag = 0
            optionButton.setTitleColor(Color.themeColor, for: .normal)
            optionButton.setTitleColor(UIColor.gray, for: .highlighted)
            optionButton.titleLabel?.font = UIFont(name:Font.regular, size:18.0)
            optionButton.addTarget(self, action: #selector(self.buttonAction(sender:)), for: .touchUpInside)
            self.containerView.addSubview(optionButton)
            
            yOffset += buttonHeight
        }
        else if buttons.count == 2 {
            var xOffset:CGFloat = 0.0
            var index:Int = 0
            let buttonWidth:CGFloat = width/2.0
            
            for buttonTitle in buttons{
                let optionButton:UIButton = UIButton()
                optionButton.frame = CGRect(x:xOffset, y:yOffset, width:buttonWidth, height:buttonHeight)
                optionButton.setTitle(buttonTitle, for: .normal)
                optionButton.tag = index
                optionButton.setTitleColor(Color.themeColor, for: .normal)
                optionButton.setTitleColor(UIColor.gray, for: .highlighted)
                optionButton.titleLabel?.font = UIFont(name:Font.regular, size:18.0)
                optionButton.addTarget(self, action: #selector(self.buttonAction(sender:)), for: .touchUpInside)
                self.containerView.addSubview(optionButton)
                
                if index == 0 {
                    let divider = UIView()
                    divider.backgroundColor = UIColor(red:221.0/255.0, green:221.0/255.0, blue:221.0/255.0, alpha:1.0)
                    divider.frame = CGRect(x:buttonWidth-1.0, y:0, width:1.0, height:buttonHeight)
                    optionButton.addSubview(divider)
                }
                
                xOffset += buttonWidth;
                index = index+1;
            }
            
            yOffset += buttonHeight
            
        }
        
        let xOffset:CGFloat = self.containerView.frame.origin.x
        
        self.containerView.frame = CGRect(x:xOffset, y:self.frame.size.height, width:width, height:yOffset)
        self.alertWindow?.bringSubviewToFront(self)
        self.showAgain = true
        
        self.perform(#selector(self.showAlert), with: nil, afterDelay: 0.5)
        
        if self.visible {
            return
        }
        
        self.visible = true
        
        self.containerView.frame = CGRect(x:xOffset, y:(self.frame.size.height-self.containerView.frame.size.height)/2.0, width:width, height:yOffset)
        self.containerView.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1.0
            self.containerView.transform = CGAffineTransform.identity
        }
    }
    
    @objc func showAlert(){
        
        let width:CGFloat = self.containerView.frame.size.width
        let xOffset:CGFloat = self.containerView.frame.origin.x
        
        if self.visible && self.showAgain {
            self.alpha = 1.0
            self.containerView.frame = CGRect(x:xOffset, y:(self.frame.size.height-self.containerView.frame.size.height)/2.0, width:width, height:yOffset)
        }
        else if self.alpha == 0.0 && self.visible {
            self.alpha = 1.0
            self.containerView.frame = CGRect(x:xOffset, y:(self.frame.size.height-self.containerView.frame.size.height)/2.0, width:width, height:yOffset)
        }
    }
    
    
    @objc func buttonAction(sender:UIButton){
        self.visible = false
        self.showAgain = false
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0.0
        }) { (finished) in
            if finished {
                if self.customAlertButtonActionCallBack != nil {
                    self.customAlertButtonActionCallBack!(sender.tag)
                }
            }
        }
    }
}

func customAlert() -> CustomAlert{
    return CustomAlert.sharedInstance
}

