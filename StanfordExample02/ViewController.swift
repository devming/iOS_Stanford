//
//  ViewController.swift
//  StanfordExample02
//
//  Created by Minki on 2017. 9. 26..
//  Copyright © 2017년 Minki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyDisplay = display.text!
            
            display.text = textCurrentlyDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        get {   // 변수를 읽을 때,
            return Double(display.text!)!    // 왜 Optional Double을 해야할까?
                                            // display.text!가 컨버팅 되지 않을 수도 있기 때문에!
        }
        set {   // 변수가 set 될 때,
            display.text = "\(newValue)"
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue) // 연산자 설정
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        
        displayValue = brain.result
    }
    
    /* Original Function of performOperation
     
     private func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
     
        if let mathematicalSymbol = sender.currentTitle {
            switch symbol {
            case "π":
                displayValue = Double.pi
            case "√":
                displayValue = sqrt(displayValue)
            default:
                displayValue = -1
            }
        }
     
        displayValue = brain.result
     }
     */
}

