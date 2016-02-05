//
//  ViewController.swift
//  Calculatr
//
//  Created by Jeremy Whiteside - 200249654
//  Created on February 5, 2016
//  Copyright © 2016 Jeremy Whiteside. All rights reserved.
//
//  This app is a simple calculator app.  It allows you to add, subtract, divide, and multiply float or whole numbers.
//  It also supports the use of negative numbers in equations.
//
//  I used a very simple layout for my calculator.  The colors are flat greyscale colors, with accented function keys (not numbers)
//  The font used is Helvetica Neue

import UIKit

class ViewController: UIViewController {

    //These global variables control the live inputs and those stored in memory, the most recent arithmetic operator.
    
    let clearedDisplayString = "0"
    var currentDisplayString = "0"
    var currentDisplayDouble: Double = 0
    var previousDisplayDouble: Double = 0
    var mostRecentInputDouble: Double = 0
    var arithmeticOperatorString = String()
    var firstNumberBoolean = true
    var negativeNumberBoolean = false
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        //On load, update the display to the default value (0)
        
        super.viewDidLoad()
        updateDisplay()
    }

    @IBAction func clearDisplay(sender: UIButton) {
        //This function is called when the user presses the "Clear" button.
        //It resets all globabl variables to their default state, and clears the display
        
        currentDisplayString = clearedDisplayString
        firstNumberBoolean = true
        negativeNumberBoolean = false
        currentDisplayDouble = 0
        previousDisplayDouble = 0
        arithmeticOperatorString = ""
        mostRecentInputDouble = 0
        updateDisplay()
    }
    
    @IBAction func numberInputHandler(sender: AnyObject) {
        //This function handles the input of any numbers.  Whenever a number is pressed on the numpad,
        //this function will determine the numerical value of that button, and add it to the display.
        //It also has logic to prevent leading zeroes when inputing numbers
        
        if firstNumberBoolean == true {
            currentDisplayString = ""
            firstNumberBoolean = false
        }
        currentDisplayString += sender.titleLabel!!.text!
        mostRecentInputDouble = Double(currentDisplayString)!
        updateDisplay()
    }
    
    @IBAction func eraseCharacter(sender: AnyObject) {
        //This function handles the erase button.  When it is pressed, this function will erase the last number on the display.
        //When the last number is erased, the display is reset to 0
        
        if currentDisplayString.characters.count > 1{
            currentDisplayString.removeAtIndex(currentDisplayString.endIndex.predecessor())
        }
        else{
            currentDisplayString = "0"
            firstNumberBoolean = true
        }
        mostRecentInputDouble = Double(currentDisplayString)!
        updateDisplay()
    }
    
    @IBAction func decimalInputHandler(sender: AnyObject) {
        //This function handles the decimal button.  It ensures that there can only be one decimal on the display at any time.
        //If there is a decimal, it will prevent the addition of a second one
        if !currentDisplayString.containsString("."){
            currentDisplayString += sender.titleLabel!!.text!
            firstNumberBoolean = false
        }
        mostRecentInputDouble = Double(currentDisplayString)!
        updateDisplay()
    }
    
    @IBAction func negativeInputHandler(sender: AnyObject) {
        //This function handles the negative/positive button.  If the number in the display is positive, it will add a minus symbol infront of it.
        //If the number is already negative, it will remove the minus symbol
        
        //If there is no number on the display, it will not input a minus symbol
        if firstNumberBoolean == false {
            
            //If the number displayed is positive
            if negativeNumberBoolean == false{
                currentDisplayString = "-" + currentDisplayString
                negativeNumberBoolean = true
            }
                
            //If the number is already negative
            else{
                currentDisplayString = String(currentDisplayString.stringByReplacingOccurrencesOfString("-", withString: ""))
            }
            
            mostRecentInputDouble = Double(currentDisplayString)!
        }
        updateDisplay()
    }
    
    @IBAction func operatorInputHandler(sender: AnyObject) {
        //This function handles the arithmetic operators, and the equals button.
        //It has separate logic for the operators and for the equals button.
        
        //If the input is not and equals sign, it is either +, -, X, /
        if !(sender.titleLabel!!.text)!.containsString("="){
            previousDisplayDouble = Double(currentDisplayString)!
            arithmeticOperatorString = sender.titleLabel!!.text!
            negativeNumberBoolean = false
        }
        
        //If the input is an equals sign
        else{
            currentDisplayDouble = Double(currentDisplayString)!
            
            switch arithmeticOperatorString{
            
            //If the most recent arithmetic operator is division
            case "/":
                currentDisplayDouble = (previousDisplayDouble / mostRecentInputDouble)
                currentDisplayString = String(currentDisplayDouble)
                previousDisplayDouble = Double(currentDisplayString)!
                
            //If the most recent arithmetic operator is multiplication
            case "X":
                currentDisplayDouble = (previousDisplayDouble * mostRecentInputDouble)
                currentDisplayString = String(currentDisplayDouble)
                previousDisplayDouble = Double(currentDisplayString)!
                
            //If the most recent arithmetic operator is addition
            case "+":
                currentDisplayDouble = (previousDisplayDouble + mostRecentInputDouble)
                currentDisplayString = String(currentDisplayDouble)
                previousDisplayDouble = Double(currentDisplayString)!
                
            //If the most recent arithmetic operator is subtraction
            case "-":
                currentDisplayDouble = (previousDisplayDouble - mostRecentInputDouble)
                currentDisplayString = String(currentDisplayDouble)
                previousDisplayDouble = Double(currentDisplayString)!
                
            default:
                break
                
            }
            
            updateDisplay()

            
        }
        
        firstNumberBoolean = true
    }
    
    func updateDisplay(){
        //This function updates the display with the contents of currentDisplayString
        //It is called every time the user enters a number, clears the display, deletes a digit, or presses the equals button.
        
        displayLabel.text = currentDisplayString
    }

}

