//
//  StoreDataVM.swift
//  MachineTestByKiran
//
//  Created by Kiran PM on 21/06/23.
//

import UIKit
import FirebaseDatabase

class StoreDataVM{
    fileprivate var ref: DatabaseReference!
    
    public var successClosure: (() -> ())?
    public var failureClosure:(() -> ())?
    public var loadingStatus:(() -> ())?
    
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
    
    public var dataSnapshot: DataSnapshot? {
        didSet{
            self.successClosure?()
        }
    }
    
}


extension StoreDataVM{
    public func callRegisterNewUser(params: [String:String]) {
        
        self.isLoading = true
        
        ref = Database.database().reference()
        
        ref.child("Users").childByAutoId().setValue(params) { [weak self] error, _ in
            self?.isLoading = false

            if let error = error {
                self?.alertMessage = error.localizedDescription
            } else {
                self?.successResponse = true
            }
        }
    }
    
    
    public func callFetchAllUsers() {
        
        self.isLoading = true
        var ref: DatabaseReference!
        ref = Database.database().reference()

        ref.observe(.childAdded) {[weak self] snapshot in
            self?.isLoading = false

            if snapshot.exists() {
                self?.dataSnapshot = snapshot
            }
            else {
                self?.alertMessage = "No data found"

                }
    

        }
    }

}
