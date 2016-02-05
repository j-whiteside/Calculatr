//
//  ViewController.swift
//  Calculatr
//
//  Created by student on 2016-02-02.
//  Copyright © 2016 student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let clearedDisplayString = "0"
    // let numberInputArray: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var currentDisplayString = "0"
    var currentDisplayDouble: Double = 0
    var previousDisplayDouble: Double = 0
    var firstNumberBoolean = true
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDisplay()
    }

    @IBAction func clearDisplay(sender: UIButton) {
        currentDisplayString = clearedDisplayString
        firstNumberBoolean = true
        updateDisplay()
    }
    
    @IBAction func numberInputHandler(sender: AnyObject) {
        if firstNumberBoolean == true {
            currentDisplayString = ""
            firstNumberBoolean = false
        }
        currentDisplayString += sender.titleLabel!!.text!
        updateDisplay()
    }
    
    @IBAction func eraseCharacter(sender: AnyObject) {
        if currentDisplayString.characters.count > 1{
            currentDisplayString.removeAtIndex(currentDisplayString.endIndex.predecessor())
        }
        else{
            currentDisplayString = "0"
            firstNumberBoolean = true
        }
        updateDisplay()
    }
    
    @IBAction func decimalInputHandler(sender: AnyObject) {
        if !currentDisplayString.containsString("."){
            currentDisplayString += sender.titleLabel!!.text!
            firstNumberBoolean = false
        }
        updateDisplay()
    }
    
    
    @IBAction func operatorInputHandler(sender: AnyObject) {
        switch sender.titleLabel!!.text{
            case "/":
            
            
            case "X":
            
            
            case "+":
            
            
            case "-":
            
            
            case "=":
            
            
            
        }
        previousDisplayDouble = Double(currentDisplayString)!
        firstNumberBoolean = true
    }
    
    func updateDisplay(){
        displayLabel.text = currentDisplayString
    }

}

