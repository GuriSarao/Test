//
//  CustomNavigationController.swift
//  Social Media App
//
//  Created on 03/08/19.
//  Copyright © 2019. All rights reserved.
//


import Foundation
import UIKit

typealias VCIdentifier = ViewControllerIdentifier
typealias SB = StoryBoard
typealias CI = CellIdentifier


/// Storyboard names
struct StoryBoard {
    static let main = "Main" // CORRECT
}

struct APP {
    static let secretKey = "8DwYXC36dyYVEXTKR8IWbBwMy1XAj2hXtuJ2n2My"
    static let key = "51lvMqDQNP"
    static let form = "application/x-www-form-urlencoded"
}


/// View Controller Identifiers from Storyboards
struct ViewControllerIdentifier {
    static let Start = "StartVC"
    static let Main = "MainVC"
}


/// Cell Identifiers from Storyboards
struct URLs {
    static let termsOfService  = "https://google.com"
    static let privacyPolicy  = "https://google.com"
}


/// Cell Identifiers from Storyboards
struct CellIdentifier {
    static let MainCell = "MainTableViewCell"
    static let detailCell = "DetailTableViewCell"
}


/// Header Identifiers from Storyboards
struct Headerdentifier {
    static let MainHeader = "MainHeader"
}

struct Constant {
    static let titleKey = "Title"
}


struct Font {
    static let regular   = "SF UI Text"
    
    static let navigationTitleTextFont:UIFont = Device.IS_IPAD ? UIFont(name:Font.regular, size:20.0)! :  UIFont(name:Font.regular, size:20.0)!
    static let tabbarTitleTextFont:UIFont = Device.IS_IPAD ? UIFont(name:Font.regular, size:16.0)! :  UIFont(name:Font.regular, size:11.0)!
    static let termsFont:UIFont = Device.IS_IPAD ? UIFont(name:Font.regular, size:16.0)! :  UIFont(name:Font.regular, size:15.0)!
}


struct Color {
    static let themeColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    static let DescriptiontextColor = UIColor(red: 45.0/255.0, green: 47.0/255.0, blue: 51.0/255.0, alpha: 1)
    
    
    static let theme1Color = UIColor(red: 66.0/255.0, green: 73.0/255.0, blue: 255.0/255.0, alpha: 1)
    static let theme2Color = UIColor(red: 84.0/255.0, green: 194.0/255.0, blue: 247.0/255.0, alpha: 1)
    
}

struct NavigationTitles {
    static let chat = "Chats"
    static let networking = "Network"
    static let ratings = "Ratings"
    static let profile = "My Profile"
    static let ratingBreakDown = "Rating Breakdown"
    
}

enum UIUserInterfaceIdiom : Int{
    case Unspecified
    case Phone
    case Pad
}

struct ScreenSize{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}


struct Device {
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH >= 812.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad
    
    static func aspectRatio() -> CGFloat{
        if Device.IS_IPAD{
            return 2.0
        }
        //return 1.0
        
        let standardRatio:CGFloat = 320.0/568.0
        let newResolution:CGFloat = (UIScreen.main.bounds.size.width)/(UIScreen.main.bounds.size.height);
        
        if (Float((UIScreen.main.bounds.size.height)) > 500.0 && Float((UIScreen.main.bounds.size.height)) < 600.0){
            return 1.0;
        }
        
        if(Float((UIScreen.main.bounds.size.height)) > 568.0){
            return standardRatio+newResolution;
        }else{
            return 1.0;
        }
    }
}
