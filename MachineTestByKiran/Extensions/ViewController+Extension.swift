//
//  ViewController+Extension.swift
//  MachineTestByKiran
//
//  Created by Kiran PM on 20/06/23.
//

import UIKit


extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    // Set AlertView
    func displayValidationMsg(withMessage message: String) {
        
        let actionSheet: UIAlertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "OK", style: .cancel)
        
        actionSheet.addAction(cancelActionButton)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // Set AlertView with Action
        func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            for (index, title) in actionTitles.enumerated() {
                let action = UIAlertAction(title: title, style: .default, handler: actions[index])
                alert.addAction(action)
            }
            self.present(alert, animated: true, completion: nil)
        }
    
    
}
