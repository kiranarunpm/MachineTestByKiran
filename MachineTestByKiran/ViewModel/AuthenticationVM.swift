//
//  AuthenticationVM.swift
//  MachineTestByKiran
//
//  Created by Kiran PM on 21/06/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AuthenticationVM{
    
    public var successClosure: (() -> ())?
    public var failureClosure:(() -> ())?
    public var loadingStatus:(() -> ())?
    public var successClosureUserExist:(() -> ())?

    public var successResponse: Bool? {
        didSet{
            self.successClosure?()
        }
    }
    
    public var alertMessage: String? {
        didSet{
            self.failureClosure?()
        }
    }
    
    public var isLoading:Bool? {
        didSet{
            self.loadingStatus?()
        }
    }
    
    public var currentVerificationId: String = "" {
        didSet{
            self.successClosure?()
        }
    }
    
    public var userID: String = "" {
        didSet{
            self.successClosure?()
        }
    }
    
    public var isUserExist:Bool? {
        didSet{
            self.successClosureUserExist?()
        }
    }
}

extension AuthenticationVM{
    
    //MARK: Definition of sent OTP for given number
    public func callSendOTP(mobileNumber: String) {
        self.isLoading = true

        let phoneNumber = "\(Constants.phone_code)\(mobileNumber)"
        Auth.auth().languageCode = "en"
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] (verificationID, error)  in
         self?.isLoading = false

          if let error = error {
              self?.alertMessage = error.localizedDescription
            return
          }
            self?.currentVerificationId = verificationID!
        }
    }
    
    //MARK: Definition of verify Mobile Number
    public func callVerifyOTP(withVerificationID: String, verificationCode: String) {
        self.isLoading = true
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: withVerificationID, verificationCode: verificationCode)
        Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
            self?.isLoading = false
            if let error = error {
                let authError = error as NSError
                self?.alertMessage = authError.description
                return
            }
            
            let currentUserInstance = Auth.auth().currentUser?.uid
            self?.userID = currentUserInstance ?? ""

        }
    }
    
    //MARK: Definition for Check User alredy Register account
    public func checkRegistedUser(userID: String, handler: @escaping ((Bool)->Void)){
        let databaseRef = Database.database().reference()
        let usersRef = databaseRef.child("Users")
        usersRef.observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                if let users = snapshot.value as? [String: Any] {
                    for (_, userData) in users {
                        if let user = userData as? [String: Any] {

                            for (_, value) in user {
                                if value as! String == userID{
                                    handler(true)
                                    return
                                }
                            }
                        }
                    }
                }
            } else {

            }
            handler(false)

        }
    }
}
