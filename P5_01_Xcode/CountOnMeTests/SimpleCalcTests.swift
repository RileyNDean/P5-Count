//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //Add Number Tests
    func testGivenNewCalculatorWhenDigitClickedThenFormulaShouldUpdate() {
        // Given
        let calculator = Calculator()
        // When
        calculator.addNumber(number: "4")
        //Then
        XCTAssertEqual(calculator.formula, "4")
    }
    
    func testGiveEqualFourWhenDigitClickedThenFormulaEqualOne() {
        let calculator = Calculator()
        calculator.formula = "= 4"
        calculator.addNumber(number: "1")
        XCTAssertEqual(calculator.formula, "1")
    }
    
    func testGiveEqualFourWhenDigitClickedThenexpressionHaveResultIsTrue() {
        let calculator = Calculator()
        calculator.formula = "= 4"
        XCTAssertTrue(calculator.expressionHaveResult)
    }
    
    //Add Operand Tests
    func testGivenNewCalculatorWhenAddOpenrandThenCanAddOperatorIsFalse() {
        let calculator = Calculator()
        calculator.addPlus()
        XCTAssertFalse(calculator.canAddOperator)
    }
    
    func testGivenOneNumberWhenAddOpperandThenAddOperand() {
        let calculator = Calculator()
        calculator.formula = "4"
        calculator.addPlus()
        XCTAssertEqual(calculator.formula, "4 + ")
    }
    
    func testGivenOneNumberAndOneOperrandWhenAddOpperandThenCanAddOperatorIsFalse() {
        let calculator = Calculator()
        calculator.formula = "4 +"
        calculator.addPlus()
        XCTAssertFalse(calculator.canAddOperator)
    }
    
    //Equal Tests
    
    func testGiven4Plus4WhenClickedEqualThenResultIs8() {
        let calculator = Calculator()
        calculator.formula = "4 + 4"
        calculator.equal()
        XCTAssertEqual(calculator.formula, "= 8")
    }
    
    func testGiven5Minus10WhenClickedEqualThenResultIsMinus() {
        let calculator = Calculator()
        calculator.formula = "5 - 10"
        calculator.equal()
        XCTAssertEqual(calculator.formula, "= -5")
    }
    
    func testGiven4Plus4Times3WhenClickedEqualThenResultIs16() {
        let calculator = Calculator()
        calculator.formula = "4 + 4 × 3"
        calculator.equal()
        XCTAssertEqual(calculator.formula, "= 16")
    }
    
    func testGiven4Plus6DevidedBy3WhenClickedEqualThenResultIs6() {
        let calculator = Calculator()
        calculator.formula = "4 + 6 ÷ 3"
        calculator.equal()
        XCTAssertEqual(calculator.formula, "= 6")
    }
    
    func testGiven4PlusWhenClickedEqualThenexpressionIsCorrectIsFalse() {
        let calculator = Calculator()
        calculator.formula = "4 +"
        calculator.equal()
        XCTAssertFalse(calculator.expressionIsCorrect)
    }
    
    func testGiven4WhenClickedEqualThenexpressionHaveEnoughElementIsFalse() {
        let calculator = Calculator()
        calculator.formula = "4"
        calculator.equal()
        XCTAssertFalse(calculator.expressionHaveEnoughElement)
    }
    
    //Reset Test
    func testGiveAddOneNumberWhenResetClickedThenCleanFormula() {
        let calculator = Calculator()
        calculator.addNumber(number: "4")
        calculator.resetCalcul()
        XCTAssertEqual(calculator.formula, "")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
