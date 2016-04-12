//
//  ViewController.swift
//  Calculator
//
//  Created by Josh Broomberg on 2016/04/10.
//  Copyright © 2016 iXperience. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var inputInProcess = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        func append(value: String=digit){
            display.text = display.text! + value
        }
        
        if inputInProcess {
            
            if digit == "." {
                var decimal = false
                for char in display.text!.characters {
                    if char == "." {
                        decimal = true
                    }
                }
                if !decimal {
                    append()
                }
            }
            else if digit == "π" {
                
            }
            else {
                append("\(M_PI)")
            }
            
        }
        else {
            display.text = digit
            inputInProcess = true
        }
        
        
        
    }
    
    var operatingStack = Array<Double>()
    
    @IBAction func enter() {
        inputInProcess = false
        operatingStack.append(displayValue)
        print("\(operatingStack)")
        
    }
    
    @IBAction func clear() {
        operatingStack = []
        display.text = "0"
        inputInProcess = false
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        print("\(operation)")
        if inputInProcess{
            enter()
        }
        
        switch operation {
            case "*": performOperation {$0 * $1}
            case "+": performOperation {$0 + $1}
            case "-": performOperation {$1 - $0}
            case "/": performOperation {$1 / $0}
            case "√": performSingleOperation {sqrt($0)}
            case "sin": performSingleOperation {sin($0)}
            case "cos": performSingleOperation {cos($0)}
            default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operatingStack.count >= 2 {
            displayValue = operation(operatingStack.removeLast(), operatingStack.removeLast())
            enter()
        }
    }
    
    func performSingleOperation(operation: Double -> Double) {
        if operatingStack.count >= 1 {
            displayValue = operation(operatingStack.removeLast())
            enter()
        }
    }
    
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        
        set {
            display.text = "\(newValue)"
            inputInProcess = false
        }
    }
}

