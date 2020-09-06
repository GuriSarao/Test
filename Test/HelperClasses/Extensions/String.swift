//
//  String.swift
//

import UIKit

extension String {
    func isStrongPassword() -> Bool {
        var returnValue = true
        let regEx = "^.*(?=.{8,})(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).*$"
        do {
            let regex = try NSRegularExpression(pattern: regEx)
            let results = regex.matches(in: self, range: NSRange(location: 0, length: self.count))
            if results.isEmpty {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    
    func isValidEmailAddress() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }

    func isAlphabetsString() -> Bool {
        var returnValue = true
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        if trimmedString == "" || trimmedString.isEmpty {
            return false
        }
        
        let nameEx = "^[a-zA-Z0-9._@ -]+$"
        do {
            let regex = try NSRegularExpression(pattern: nameEx)
            let results = regex.matches(in: trimmedString, range: NSRange(location: 0, length: trimmedString.count - 1))
            if results.isEmpty {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }

    static func convertDeviceTokenToString(_ deviceToken: Data) -> String {
        //  Convert binary Device Token to a String (and remove the <,> and white space charaters).
        var token = ""
        for i in 0..<deviceToken.count {
            token += String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        return token
    }
}
