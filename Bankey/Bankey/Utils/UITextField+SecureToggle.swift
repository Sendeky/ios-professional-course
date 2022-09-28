//
//  UITextField+SecureToggle.swift
//  Bankey
//
//  Created by RuslanS on 9/27/22.
//

//Normal mode = Image of "eye.fill'
//Selected mode = Image of "eyeSlash.fill'
//Calls function when button is touched
//passwordToggleButton is actually added to the RIGHT SIDE
//Button is always visible
//Toggle for dots over password
//Adds dots property to the textfield to which the toggleButton is added

import Foundation
import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField {
    func enablePasswordToggl() {
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)                        //Normal mode = Image of "eye.fill'
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)                 //Selected mode = Image of "eyeSlash.fill'
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)    //Calls function when button is touched
        rightView = passwordToggleButton                                                                    //passwordToggleButton is actually added to the RIGHT SIDE
        rightViewMode = .always                                                                             //Button is always visible
    }
    
    @objc func togglePasswordView(sender: Any) {
        isSecureTextEntry.toggle()                                                                          //Toggle for dots over password
        passwordToggleButton.isSelected.toggle()                                                            //Adds dots property to the textfield to which the toggleButton is added
        
    }
}

