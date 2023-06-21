//
//  UserModel.swift
//  MachineTestByKiran
//
//  Created by Kiran PM on 21/06/23.
//

import UIKit

class UserModel{
    
    let email : String
    let firstname: String
    let lastname : String
    let username: String
    let userID: String
    let mobile: String

    
    init(email: String, firstname: String, lastname: String, username: String,userID: String, mobile: String) {
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
        self.username = username
        self.userID = userID
        self.mobile = mobile

    }
    
    var fullname : String{
        return "\(firstname ) \(lastname)"
    }
    
}
