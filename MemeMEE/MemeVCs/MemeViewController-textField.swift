//
//  memeViewController-textField.swift
//  MemeMEE
//
//  Created by khalid alhazmi on 18/03/2019.
//  Copyright © 2019 khalid alhazmi. All rights reserved.
//

import Foundation
import UIKit
extension MemeViewController: UITextFieldDelegate  {
    
    //setupTextField
    func setupTextField(_ textField: UITextField , text : String) {
        textField.text = text
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = self
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        cancelButton.isEnabled = true
        shareButton.isEnabled = true
        if(self.topfisrtinput){
            textField.text=""
            topfisrtinput = false
        }
        else if(self.bottomfisrtinput){
            textField.text=""
            bottomfisrtinput = false
        }
        if (textField == bottomTextField){ subscribeToKeyboardNotifications() }
    }
    
    
    //return of the keyboard and move the screen down in bottom text
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(textField == bottomTextField){
            unsubscribeFromKeyboardNotifications()
        }
        return true
    }
}
