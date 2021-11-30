//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CalculatorDelegate {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    let calculatorLogic = Calculator()
    let errors = ErrorController()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        calculatorLogic.delegate? = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculatorLogic.addNumber(number: numberText)
        formulaChanged(formula: calculatorLogic.formula)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculatorLogic.addPlus()
        formulaChanged(formula: calculatorLogic.formula)
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculatorLogic.addSubstraction()
        formulaChanged(formula: calculatorLogic.formula)
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        calculatorLogic.addMultiplication()
        formulaChanged(formula: calculatorLogic.formula)
    }
    @IBAction func tappedResetButton(_ sender: UIButton) {
        calculatorLogic.resetCalcul()
      
    }
    
    @IBAction func tappedDivisionButtion(_ sender: UIButton) {
        calculatorLogic.addDivision()
      
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
       /* guard calculatorLogic.expressionIsCorrect(elements) else {
            return errors.expressionError(controller: self)
        }
        
        guard calculatorLogic.expressionHaveEnoughElement(elements) else {
            return errors.newCalculError(controller: self)
        }
    
        let operationsToReduce = calculatorLogic.equal(operationsToReduce: elements)
        textView.text.append(" = \(String(describing: operationsToReduce!))")*/
    }

    // MARK: CalculatorDelegate
    func formulaChanged(formula: String) {
        textView.text = formula
    }
    
    func errorHappened(error: CalculatorError) {
        switch error{
        case .operator : errors.opperatorError(controller: self)
        case .expression : errors.expressionError(controller: self)
        case .newCalcul : errors.newCalculError(controller: self)
        }
    }
}

