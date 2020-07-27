//
//  ViewController.swift
//  TipPal
//
//  Created by Theron Mansilla on 7/26/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

        // MARK: - Outlets and Properties
        @IBOutlet weak var headerLabel: UILabel!
        
        @IBOutlet weak var billAmountTextField: CurrencyTextField!
        
        @IBOutlet weak var tipPercentageLabel: UILabel!
        @IBOutlet weak var tipPercentageSlider: UISlider!
        @IBOutlet weak var tipPercentageValueLabel: UILabel!
        
        @IBOutlet weak var totalBillLabel: UILabel!
        @IBOutlet weak var totalBillValueLabel: UILabel!
        
        var tipPercentages:[Int] = [10,15,20]
        
        let currencyFormatter = NumberFormatter()
        
        var billAmount:Double = 0.00
       
        
        // MARK: - ViewWillAppear
        override func viewWillAppear(_ animated: Bool) {
            // Style the view and its elements before the view appears
            ViewControllerStyler.styleHeaderLabel(label: headerLabel)
            ViewControllerStyler.styleBillAmountTextField(textField: billAmountTextField)
            ViewControllerStyler.styleTipPercentageLabel(label: tipPercentageLabel)
            ViewControllerStyler.styleTipPercentageValueLabel(label: tipPercentageValueLabel)
            ViewControllerStyler.styleTotalBillLabel(label: totalBillLabel)
            ViewControllerStyler.styleTotalBillValueLabel(label: totalBillValueLabel)
            
            // Add placeholder text to "billAmountTextField"
            billAmountTextField.attributedPlaceholder = NSAttributedString(string: "$0.00", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            // Make "billAmountTextField" the firstResponder
            billAmountTextField.becomeFirstResponder()
            billAmountTextField.clearsOnBeginEditing = true
            
            // Configure "currencyFormatter"
            currencyFormatter.locale = .current
            currencyFormatter.numberStyle = .currency
            currencyFormatter.minimumFractionDigits = 2
            
            // Add notification observing for when "billAmountTextField" is edited
            NotificationCenter.default.addObserver(self, selector: #selector(calculateTotalBill(notification:)), name: NSNotification.Name(rawValue: "billAmountTextFieldEdited"), object: nil)
        }
       
        
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            
        // Set the delegate of billAmountTextField
        billAmountTextField.delegate = self
            
        // Set up a tap gesture to exit the keyboard once the user taps elsewhere in the view
        let viewControllerTapped = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(viewControllerTapped)
            
        // Display the initial percentage value on "tipPercentageValueLabel"
        let formattedPercentageValue = String(format: "%.f", tipPercentageSlider.value)
        tipPercentageValueLabel.text = "\(formattedPercentageValue)%"
    }
}


// MARK: - billAmountTextField Methods
extension ViewController:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        totalBillValueLabel.text = currencyFormatter.string(from: NSNumber(value: 0))
        billAmountTextField.enteredDigits = ""
    }
}


// MARK: - tipPercentageSlider Methods
extension ViewController {
    @IBAction func tipPercentageSliderValueChanged(_ sender: Any) {
        // Display the new percentage value
        tipPercentageValueLabel.text = String(format: "%.f", tipPercentageSlider.value) + "%"
            
        // Calculate, then display, the new total bill
        displayTotalBill()
    }
}


// MARK: - Calculate/Display Total Bill Methods
extension ViewController {
    @objc func calculateTotalBill(notification:Notification) {
        // Update the balue of "self.billAmount"
        self.billAmount = notification.userInfo!["billAmount"] as! Double
            
        // Calculate, then display, the total bill
        displayTotalBill()
    }
        
    func displayTotalBill() {
        let tip = Double(tipPercentageSlider.value.rounded() / 100) * self.billAmount
            
        let totalBill = self.billAmount + tip
            
        totalBillValueLabel.text = currencyFormatter.string(from: NSNumber(value: totalBill))
    }
}


