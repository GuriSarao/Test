//
//  UserInfo.swift
//  Test
//
//  Created by Gursewak singh on 04/09/20.
//  Copyright © 2020 Gursewak singh. All rights reserved.
//

import UIKit

var data = ["Today" : [[
"titles" : "DIARY TITLE",
"Description" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
"Dates" : "2 hours ago"
]],"Yesterday" : [[
            "titles" : "DIARY TITLE",
            "Description" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Et felis amet enim faucibus ornare nisl euismod. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Et felis amet enim faucibus ornare nisl euismod.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Et felis amet enim faucibus ornare nisl euismod.Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
            "Dates" : "18 hours ago"
            ],[
                "titles" : "DIARY TITLE",
                "Description" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                "Dates" : "20 hours ago"
            ]],"Apr" : [[
                "titles" : "DIARY TITLE",
                "Description" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                "Dates" : "6 weeks ago"]]
    ] as NSDictionary

var titles = ""
var Descriptions = ""

class UserInfo: NSObject {
    var data = [MainHeader]()
    
    static let sharedInstance =  UserInfo()
}

func userInfo() -> UserInfo{
    return UserInfo.sharedInstance
}
