//
//  RegistedUserCell.swift
//  MachineTestByKiran
//
//  Created by Kiran PM on 21/06/23.
//

import UIKit

class RegistedUserCell: UITableViewCell {
    @IBOutlet weak var usernameTxt: UILabel!
    @IBOutlet weak var fullnameTxt: UILabel!
    
    static var identifire = "RegistedUserCell"
    @IBOutlet weak var emailTxt: UILabel!
    
    @IBOutlet weak var mobileTxt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
