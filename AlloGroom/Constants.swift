//
//  Constants.swift
//  vici_mitch
//
//  Created by Mitch on 6/29/18.
//  Copyright © 2018 Mitch. All rights reserved.
//

import Foundation

struct Keys {  // keys for parameters
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let desiredUserName = "desiredUsername"
    static let mobileNumber = "mobileNumber"
    static let email = "email"
    static let password = "password"
    static let photoStorage = "photoStorage"
    static let uniqueID = "uniqueID"
    static let targetEmail = "targetEmail"
    static let ratingValue = "ratingValue"
    static let ratingKey = "ratingKey"
    static let userEmail = "userEmail"
}

struct URL {
    static let login = "http://mitch.beanstalkweb.com/login.php"
    static let register = "http://mitch.beanstalkweb.com/register.php"
    static let updateUser = "http://mitch.beanstalkweb.com/updateUser.php"
    static let addToRatingTable = "http://mitch.beanstalkweb.com/addToRatingTable.php"
    static let getTraits = "http://mitch.beanstalkweb.com/getTraits.php"
}



struct JSONResponseStruct: Decodable {
    let error: Bool?
    let message: String?
    let uniqueID: String?
    let firstName: String?
    let lastName: String?
    let desiredUsername: String?
    let email: String?
    let mobileNumber: String?
    let photoStorage: String?
}

struct CurrentUser{
    static var error: Bool? = false
    static var message: String? = ""
    static var uniqueID: String? = ""
    static var firstName: String? = ""
    static var lastName: String? = ""
    static var desiredUsername: String? = ""
    static var email: String? = ""
    static var mobileNumber: String? = ""
    static var photoStorage: String? = ""
    static var targetEmail: String? = ""
}

struct ContactStruct {
    let firstName: String
    let lastName: String?
    let email: NSString
}

struct TraitStruct {
    let name: String
    let traitKey: String
    let inUseBool: Bool
}
