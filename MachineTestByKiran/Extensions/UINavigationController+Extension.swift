//
//  UINavigationController+Extension.swift
//  MachineTestByKiran
//
//  Created by Kiran PM on 21/06/23.
//

import UIKit

extension UINavigationController{
    
    //MARK: Set Login VC as RootView Controller
    func toLoginVC() {
        guard let rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {
            return
        }
        let navigationController = UINavigationController(rootViewController: rootVC)
        navigationController.navigationBar.isHidden = true
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    //MARK: Set ListOFUserVC  as RootView Controller
    func listOfUsersVC() {
        guard let rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListOfUsersVC") as? ListOfUsersVC else {
            return
        }
        let navigationController = UINavigationController(rootViewController: rootVC)
        navigationController.navigationBar.isHidden = false
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
