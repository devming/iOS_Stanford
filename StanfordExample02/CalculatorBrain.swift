//
//  CalculatorBrain.swift
//  StanfordExample02
//
//  Created by Minki on 2017. 9. 27..
//  Copyright © 2017년 Minki. All rights reserved.
//

import Foundation

// Model에서 UIKit을 불러올 일은 없다.
/* Optional은 다음과 같다.
 
 enum Optional<T> {
    case None
    case Some(T)
 }
 
 
 */
/*
 Model 구현하기

 1. 구현에 필요한 API(함수 인터페이스)를 선언한다.
 2. 결과를 반환할 Readonly용 계산 프로퍼티를 선언한다.
 3. 필요한 행동이 중첩된다면 switch case를 사용한다.
 4. switch문을 사용할 때, enum타입으로 중첩된 대주제(여기서는 Constant, UnaryOperation, BinaryOperation, Equals)를 선언해놓는다.
    그리고 Dictionary 변수 안에서 구체적인 값(입력받은 값)에 따라, 대주제들에게 값을 넘겨준다.
 5. 함수역시 타입처럼 사용할 수 있다.
 
 */
class CalculatorBrain {
    
    private var accumulator = 0.0 // 연산하면서 누적해나감.
    
    func setOperand(operand: Double) {  //
        accumulator = operand
    }
    
    var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(Double.pi),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),  // sqrt
        "cos": Operation.UnaryOperation(cos) // cos
    ]
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation
        case Equals
    }
    
    func performOperation(symbol: String) { // 실질적인 계산하기
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let associatedConstantValue): accumulator = associatedConstantValue
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation: break
            case .Equals: break
            }
        }
        
        
//        if let constant = operations[symbol] {
//            accumulator = constant // operations가 우리가 넘겨준 symbol을 가지고 있지 않을지도  모른다.
//        }
    }
    
    var result: Double {    // 결과 값
        get {
            return accumulator
        }
    }
}
