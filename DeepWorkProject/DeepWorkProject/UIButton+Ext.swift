//
//  UIButton+Ext.swift
//  DeepWorkProject
//
//  Created by Raj Patel on 23/04/25.
//

import Foundation
import UIKit


extension UIButton {

    func cornerRadiusCustom (){
        layer.cornerRadius = layer.frame.height / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.purple.cgColor
    }
    
}
