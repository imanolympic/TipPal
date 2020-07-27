//
//  CurrencyTextField.swift
//  tip
//
//  Created by Theron Mansilla on 7/25/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit


class CurrencyTextField: UITextField {
    
    public var enteredDigits = ""
    public var backspaced = false
    public let currencyFormatter = NumberFormatter()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    private func setUp() {
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        currencyFormatter.numberStyle = .currency
        currencyFormatter.minimumFractionDigits = 2
        currencyFormatter.locale = .current
    }
}


extension CurrencyTextField {
    @objc func editingChanged() {
        defer {
            backspaced = false
            text = formatDigits(text: enteredDigits)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "billAmountTextFieldEdited"), object: nil, userInfo: ["billAmount": Double(exactly: currencyFormatter.number(from: text ?? "0.00") ?? 0) ?? 0.00])
            
        }
        
        guard backspaced == false else {
            return
        }

        if let lastEnteredCharacter = text?.last, lastEnteredCharacter.isNumber{
            enteredDigits.append(lastEnteredCharacter)
        }
    }
    
    
    override func deleteBackward() {
          enteredDigits = String(enteredDigits.dropLast())
          text = formatDigits(text: enteredDigits)
        
          backspaced = true
          
          super.deleteBackward()
      }
    
    func formatDigits(text:String) -> String {
           if text.isEmpty {
               return currencyFormatter.string(from: NSNumber(value: 0))!
           }
           else {
               return currencyFormatter.string(from: NSNumber(value: (Double(text) ?? 0) / 100))!
           }
       }
}




