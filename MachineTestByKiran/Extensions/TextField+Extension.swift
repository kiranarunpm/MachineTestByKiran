//
//  TextField+Extension.swift
//  MachineTestByKiran
//
//  Created by Kiran PM on 21/06/23.
//

import UIKit

extension UITextField{
    
    //MARK: Mobile Number Validation
    func mobileNumberValidation() ->Bool{
        let number = self.text ?? ""
        guard !number.isEmpty else {
            return false
        }
        
        guard number.count == 10, number.first != "0", number.first != "1", number.first != "2", number.first != "3", number.first != "4", number.first != "5" else {
            return false
        }
        return true
    }
    
    
}
