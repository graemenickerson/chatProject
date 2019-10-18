//
//  UserTableCell.swift
//  Final Chat Project
//
//  Created by Graeme Nickerson on 2019-03-26.
//  Copyright © 2019 Graeme Nickerson. All rights reserved.
//

import UIKit

class UserTableCell: UITableViewCell {

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var messageContainer: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var rightConstraint: NSLayoutConstraint!
    @IBOutlet var leftConstraint: NSLayoutConstraint!
    
    func cellLayoutControls (userName: String, message: String){
        
        if userName == "Graeme" {
            
            //user
            userNameLabel.text = userName
            userNameLabel.textAlignment = .right
            
            //message
            messageLabel.text = message
            messageLabel.textColor = UIColor.white
            
            //container
            messageContainer.backgroundColor = UIColor(displayP3Red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
            messageContainer.layer.masksToBounds = true
            messageContainer.layer.cornerRadius = 8
            rightConstraint.constant = 5
            messageContainer.layoutIfNeeded()
            
        } else {
            
            //user
            userNameLabel.text = userName
            userNameLabel.textAlignment = .left
            
            //message
            messageLabel.text = message
            messageLabel.textAlignment = .left
            messageLabel.textColor = UIColor.black
            
            //container
            messageContainer.backgroundColor = UIColor(displayP3Red: 192/255, green: 192/255, blue: 192/255, alpha: 1.0)
            messageContainer.layer.masksToBounds = true
            messageContainer.layer.cornerRadius = 8
            leftConstraint.constant = 5
            messageContainer.layoutIfNeeded()
        }
        
    }

}
