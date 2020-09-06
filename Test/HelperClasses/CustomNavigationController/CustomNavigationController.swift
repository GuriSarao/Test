//
//  CustomNavigationController.swift
//  Social Media App
//
//  Created on 03/08/19.
//  Copyright © 2019. All rights reserved.
//


import UIKit

enum BarButtonType : Int{
    case More
    case Notification
    case Search
    case QRCode
}

class BarButtonObject: NSObject {
    var type:BarButtonType = .Search
    var selector:Selector? = nil
}


class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showHeader()
    }
    
    func showHeader(){
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //self.navigationBar.shadowImage = UIImage()
        //self.navigationBar.isTranslucent = true
         self.navigationBar.tintColor = UIColor.black
         self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font:Font.regular]
        self.view.backgroundColor = .clear
      
//        return
//        
//        self.isNavigationBarHidden = true
//        self.view.backgroundColor = UIColor.white
//                    self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//                    self.navigationBar.shadowImage = UIImage()
//                    self.navigationBar.isTranslucent = false
//        self.navigationBar.isOpaque = true
//        self.navigationBar.barTintColor = Color.themeColor
//               self.navigationBar.tintColor = UIColor.white
//               self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font:Font.navigationTitleTextFont]
    }
 
    func showLeftTitle(_ title:String,navigationItem:UINavigationItem)  {
        self.navigationItem.title = ""
        let titleLabel = UILabel()
        titleLabel.font = Font.navigationTitleTextFont
        titleLabel.textColor = Color.themeColor
        titleLabel.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: self.navigationBar.frame.size.height)
        titleLabel.text = title
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    
    @objc func searchButtonAction(){
      
    }
    
    @objc func notificationButtonAction(){
      
    }

}

extension UIBarButtonItem
{
    /** Create custom right bar button for reduce space between right bar buttons */
    func initRightButton( imageNamed:String,  target:Any,  selector:Selector?) -> UIBarButtonItem {
        let frame = CGRect(x:0, y:0, width:25, height:25)
        //Create imageView
        let imageView = UIImageView(frame:frame)
        imageView.contentMode  = .scaleAspectFit
        imageView.image = UIImage(named: imageNamed)?.withRenderingMode(.alwaysOriginal)
        //Create Button
        let button = UIButton(frame: frame)
        if selector != nil{
            button.addTarget(target, action: selector!, for: .touchUpInside)
        }
        
        //Create View and add imageView and Button
        let view = UIView(frame: frame)
        view.addSubview(imageView)
        view.addSubview(button)
        return UIBarButtonItem(customView: view)
    }
}

