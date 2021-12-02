//
//  Calculate.swift
//  CountOnMe
//
//  Created by Dhayan Bourguignon on 26/11/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol CalculatorDelegate: NSObject
{
    func formulaChanged(formula: String)
    func errorHappened(error: CalculatorError)
}

class Calculator {
    
    var formula: String = ""
    weak var delegate: CalculatorDelegate?
    
    var elements: [String] {
        get {
            return formula.split(separator: " ").map { "\($0)" }
        }
        set {
            formula = newValue.joined(separator: " ")
        }
    }
    
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷" && formula != ""
    }
    
    // Error check computed variables
    var expressionHaveResult: Bool {
        return elements.contains("=")
    }
    
    func addNumber(number: String){
        if expressionHaveResult {
            formula = ""
        }
        formula += number
        delegate?.formulaChanged(formula: formula)
    }
    
    func addPlus()
    {
        if canAddOperator {
            formula.append(" + ")
            delegate?.formulaChanged(formula: formula)
        } else {
            delegate?.errorHappened(error: .operator)
        }
    }
    
    func addSubstraction()
    {
        if canAddOperator {
            formula.append(" - ")
            delegate?.formulaChanged(formula: formula)
        } else {
            delegate?.errorHappened(error: .operator)
        }
    }
    
    func addMultiplication()
    {
        if canAddOperator {
            formula.append(" × ")
            delegate?.formulaChanged(formula: formula)
        } else {
            delegate?.errorHappened(error: .operator)
        }
    }
    
    func addDivision()
    {
        if canAddOperator {
            formula.append(" ÷ ")
            delegate?.formulaChanged(formula: formula)
            
        } else {
            delegate?.errorHappened(error: .operator)
        }
    }
    
    func resetCalcul()
    {
        formula = "0"
        delegate?.formulaChanged(formula: formula)
        formula.removeAll()
    }
    
    func equal() {
        if expressionIsCorrect == false  {
             delegate?.errorHappened(error: .newCalcul)
         }
         
        if expressionHaveEnoughElement == false  {
            delegate?.errorHappened(error: .expression)
         } else {
             while elements.count > 1 {
                 calculateWithPriority()
             }
             elements.insert("=", at: 0)
             delegate?.formulaChanged(formula: formula)
         }
    }
    
    func calculateWithPriority() {
        if elements.contains("×") || elements.contains("÷") {
            let index = elements.firstIndex(where: {$0 == "×" || $0 == "÷"})!
            let operand = elements[index]
            
            var result: Int
            switch operand {
            case "×": result = Int(elements[index-1])! * Int(elements[index+1])!
            case "÷": result = Int(elements[index-1])! / Int(elements[index+1])!
            default: fatalError("Unknown operator !")
            }
            
            elements[index-1] = String(result)
            elements.remove(at: index+1)
            elements.remove(at: index)
        } else {
            let left = Int(elements[0])!
            let operand = elements[1]
            let right = Int(elements[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            
            elements = Array(elements.dropFirst(3))
            elements.insert("\(result)", at: 0)
        }
    
    }
}
