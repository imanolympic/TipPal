//
//  ViewControllerStyler.swift
//  tip
//
//  Created by Theron Mansilla on 7/25/20.
//  Copyright © 2020 Codepath. All rights reserved.
//


import UIKit

struct ViewControllerStyler {
    
    static func styleHeaderLabel(label:UILabel) {
        label.font = UIFont(name: "Poppins-Regular", size: 20)
        label.textColor = UIColor.white
    }
    
    static func styleSettingsButton(button:UIButton) {
        button.tintColor = UIColor(displayP3Red: 44/255, green: 45/255, blue: 46/255, alpha: 1)
    }
    
    static func styleBillAmountTextField(textField:UITextField){
        textField.font = UIFont(name: "Poppins-Regular", size: 48)
        textField.textColor = UIColor.white
    }
    
    static func styleTipPercentageLabel(label:UILabel) {
        label.font = UIFont(name: "Poppins-Regular", size: 16)
        label.textColor = UIColor.white
    }
    
    static func styleTipPercentageValueLabel(label:UILabel) {
        label.font = UIFont(name: "Poppins-Regular", size: 16)
        label.textColor = UIColor.white
    }
    
    static func styleTotalBillLabel(label:UILabel) {
        label.font = UIFont(name: "Poppins-Regular", size: 36)
        label.textColor = UIColor.black
    }
    
    static func styleTotalBillValueLabel(label:UILabel) {
        label.font = UIFont(name: "Poppins-Regular", size: 36)
        label.textColor = UIColor.black
    }
}
