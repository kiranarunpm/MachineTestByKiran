//
//  RootVC.swift
//  MachineTestByKiran
//
//  Created by Kiran PM on 20/06/23.
//

import UIKit
import FirebaseAuth
class RootVC: UINavigationController{
    
    //MARK: Set RootViewController base on User login or not
    public func GetRootVC()->UINavigationController{
        if Auth.auth().currentUser != nil{
                let storyboard = ListOfUsersVC.instantiate(fromAppStoryboard: .Main)
                let rootNC = UINavigationController(rootViewController: storyboard)
                storyboard.navigationController?.navigationBar.isHidden = false
                return rootNC
            }
            else{
                let storyboard = LoginVC.instantiate(fromAppStoryboard: .Main)
                let rootNC = UINavigationController(rootViewController: storyboard)
                storyboard.navigationController?.navigationBar.isHidden = false
                return rootNC
            }

    }
}
