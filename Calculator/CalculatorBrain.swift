//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by MAC BOOK PRO 2013 EARLY on 2022/07/15.
//  Copyright © 2022 mario. All rights reserved.
//  Model

import Foundation

class CalculatorBrain {
    private var accumulator = 0.0
    func setOperand(operand: Double) { //누적 값에 저장
        accumulator = operand
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        //"." : Operation.UnaryOperation({ Double(Int($0)) }),
        "×": Operation.BinaryOperation({ $0 * $1 }),
        "÷": Operation.BinaryOperation({ $0 / $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "−": Operation.BinaryOperation({ $0 - $1 }),
        "=": Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperand(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperaion()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperaion()
               
            }
        }
    }
    
    private func executePendingBinaryOperaion() {
        if pending != nil { //대기중인 연산이 있다면~
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator) //연산 수행
            pending = nil //연산 완료후엔 비워준다
        }
    }
    
    private var pending : PendingBinaryOperationInfo? //주어진 연산자 외에 값이 들어간다면 nil
    
    private struct PendingBinaryOperationInfo { //이항 연산을 위한 구조체
        var binaryFunction : (Double, Double) -> Double // <- 형태의 함수를 받는다
        var firstOperand: Double //이항연산의 왼쪽 값 'x' + y
    }
    
    var result : Double { //결과 값 반환 읽기 전용 프로퍼티
        get {
            return accumulator
        }
    }
}
