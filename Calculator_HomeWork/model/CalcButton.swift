//
//  CalcButton.swift
//  Calculator_HomeWork
//
//  Created by Apple on 8/21/25.
//

import Foundation
import SwiftUI
enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case mutliply = "×"
    case divide = "÷"
    case equal = "="
    case clear = "C"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .mutliply, .divide, .clear, .negative, .percent:
            return Color(.systemGray5)
        case .equal:
            return Color(.systemBlue)
        default:
            return Color(.systemGray5.withAlphaComponent(0.5))
        }
    }
}
