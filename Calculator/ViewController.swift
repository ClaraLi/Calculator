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
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTyping{
            enter()
        }
        //using this method, no extra add or multiply function needed
        //really neat, but need time to get familiar with
        switch operation{
            case"+": performOperation2 { $0 + $1 }
            case"-": performOperation2 { $1 - $0 }
            case"×": performOperation2 { $0 * $1 }
            case"÷": performOperation2 { $1 / $0 }
            case"√": performOperation1 { sqrt($0)}
            case"x²": performOperation1 { pow($0,2)}
            case"ln": performOperation1 {log($0)}
            default: break
        }
        
    }
    
    
    func performOperation1(operation: Double -> Double){
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation2(operation: (Double,Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
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

