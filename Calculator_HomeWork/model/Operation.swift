//
//  Operation.swift
//  Calculator_HomeWork
//
//  Created by Apple on 8/21/25.
//

import Foundation
enum Operation {
    case add, subtract, multiply, divide, none
    var symbol: String {
        switch self {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        case .none: return ""
        }
    }
}
