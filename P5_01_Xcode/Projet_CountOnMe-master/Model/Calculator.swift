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
    
    var elements: [String] {
       return formula.split(separator: " ").map { "\($0)" }
    }
    
    weak var delegate: CalculatorDelegate?
    
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
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
        formula = ""
    }
    
    func equal(operationsToReduce: [String]) -> String? {
        // Create local copy of operations
        var opretation = operationsToReduce
        // Iterate over operations while an operand still here
        while opretation.count > 1 {
            let left = Int(opretation[0])!
            let operand = opretation[1]
            let right = Int(opretation[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "×": result = left * right
            case "÷": result = left / right
            default: fatalError("Unknown operator !")
            }
            
            opretation = Array(opretation.dropFirst(3))
            opretation.insert("\(result)", at: 0)
            
            return String(result)
        }
        return operationsToReduce.first
    }
    
}

