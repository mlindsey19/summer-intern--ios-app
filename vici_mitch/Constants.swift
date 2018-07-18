//
//  Constants.swift
//  vici_mitch
//
//  Created by Mitch on 6/29/18.
//  Copyright © 2018 Mitch. All rights reserved.
//

import Foundation

struct Keys {
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let desiredUserName = "desiredUsername"
    static let mobileNumber = "mobileNumber"
    static let email = "email"
    static let password = "password"
}

struct URL {
    static let login = "http://mitch.beanstalkweb.com/login.php"
    static let register = "http://mitch.beanstalkweb.com/register.php"
    static let updateUser = "http://mitch.beanstalkweb.com/updateUser.php"
}

//struct User: Decodable{
//    static var uniqueID: String = ""
//    static var firstName = ""
//    static var lastName = ""
//    static var desiredUsername = ""
//    static var email = ""
//    static var mobileNumber = ""
//    static var password = ""
//    static var userProfilePhoto = ""
//    static var bio = ""
//}
//struct JSONResponse: Decodable{
//    "error": false,
//    "message": "Successfully Logged In",
//    "uid": "test_uid",
//    "user": [
//        "firstName": "test_first_name",
//        "lastName": "test_last_name",
//        "desiredUsername": "test_username",
//        "email": "test_email",
//        "mobilePhone": "test_phone_number",
//        "photoStorage": "test_photo_storage",
//        "userBio": "test_bio"
//    ]}

struct JSONResponseStruct: Decodable {
    let error: Bool?
    let message: String?
    let uid: String?
    let firstName: String?
    let lastName: String?
    let desiredUsername: String?
    let email: String?
    let mobileNumber: String?
    let photoStorage: String?
    let userBio: String?
}
struct CurrentUser{
    static var error: Bool? = false
    static var message: String? = ""
    static var uid: String? = ""
    static var firstName: String? = ""
    static var lastName: String? = ""
    static var desiredUsername: String? = ""
    static var email: String? = ""
    static var mobileNumber: String? = ""
    static var photoStorage: String? = ""
    static var userBio: String? = ""
}