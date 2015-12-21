//
//  TextFieldDelegate.swift
//  TestLayoutBeta1
//
//  Created by Hieu Vo on 12/17/15.
//  Copyright © 2015 Hieu Vo. All rights reserved.
//

import Foundation
import UIKit

struct FontStyle{
    var strokeColor = UIColor()
    var foregroundColor = UIColor()
    var font = UIFont()
    var strokeWidth = Float()
    
    init() {
        strokeColor = UIColor.blackColor()
        foregroundColor = UIColor.whiteColor()
        font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
        strokeWidth = 5.0
    }
}

class textFields : NSObject, UITextFieldDelegate{
    func textFieldDidBeginEditing(textField: UITextField) {
        if ( textField.text == "TOP") || (textField.text == "BOTTOM"){
            textField.text = ""
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}
