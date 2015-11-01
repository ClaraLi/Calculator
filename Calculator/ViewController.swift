//
//  ViewController.swift
//  Calculator
//
//  Created by Jingci Li on 10/31/15.
//  Copyright © 2015 Clara Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var userIsInTheMiddleOfTyping: Bool = false

    @IBOutlet weak var resultScreen: UILabel!

    @IBAction func appendDigit(sender: UIButton){
        let digit = sender.currentTitle!
     //   let number:Int = Int(digit)!
        if userIsInTheMiddleOfTyping{
            resultScreen.text = resultScreen.text! + digit
        }
        else{
            resultScreen.text = digit
            userIsInTheMiddleOfTyping = true
        }
        
    }
    
    var operandStack:Array<Double> = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
        operandStack.append(displayValue)
        print("\(operandStack)")
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTyping{
            enter()
        }
        switch operation{
            case"+": performOperation (add)
            case"−": performOperation (minus)
            case"×": performOperation (multiply)
            case"÷": performOperation (divide)
            default: break
        }
        /*
        //using this method, no extra add or multiply function needed
        //really neat, but need time to get familiar with
        switch operation{
            case"+": performOperation({ $0 + $1 })
            case"-": performOperation({ $1 - $0 })
            case"×": performOperation({ $0 * $1 })
            case"÷": performOperation({ $1 / $0 })
        }
        
        */
        
    }
    
    func performOperation(operation: (Double,Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    func add(op1: Double, op2: Double) -> Double{
        return op1 + op2
    }
    func minus(op1: Double, op2: Double) -> Double{
        return op2 - op1
    }
    func multiply(op1: Double, op2: Double) ->Double{
        return op1 * op2
    }
    func divide(op1: Double, op2: Double) -> Double{
        return op2 / op1
    }
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(resultScreen.text!)!.doubleValue
        }
        set{
            resultScreen.text = "\(newValue)"
            userIsInTheMiddleOfTyping = false
        }
    }

}

