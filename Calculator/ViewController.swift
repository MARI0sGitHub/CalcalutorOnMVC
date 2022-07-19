//
//  ViewController.swift
//  Calculator
//
//  Created by MAC BOOK PRO 2013 EARLY on 2022/07/14.
//  Copyright © 2022 mario. All rights reserved.
//  Controller

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTypying: Bool = false
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle! //뷰에있는 연결된 버튼에 쓰인 것을 가져와
        if userIsInTheMiddleOfTypying {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit //기존 입력 + 새입력
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTypying = true
    }
    
    private var displayValue: Double { //계산하기 위해 넘겨줄 값 프로퍼티
        get {
            return Double(display.text!)! //읽기
        }
        set{
            display.text = String(newValue) //쓰기
        }
    }
    
    private var brain = CalculatorBrain() //컨트롤러에서 모델과 교류하기 위한 객체
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTypying {
            brain.setOperand(operand: displayValue) //계산 값 설정
            userIsInTheMiddleOfTypying = false
        }
        if let mathmaticalSymbol = sender.currentTitle { //누른 버튼이 연산자 버튼이라면 계산
            brain.performOperand(symbol: mathmaticalSymbol)
        }
        displayValue = brain.result //계산 결과를 저장
    }
}
