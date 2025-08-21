import SwiftUI

struct ContentView: View {
    @State var valueOne: String = "0"
    @State var valueTwo: String = "0"
    @State var result: String = "0"
    @State var operate: String = ""
    @State var isOperate: Bool = false
    @State var isError: Bool = false
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Text(result == "0" ? "" : isError ? "" : result)
                    Spacer()
                    Text(operate)
                }
                .lineLimit(1)
                .font(.title)
                .foregroundStyle(.red)
                .padding()
                
                HStack {
                    Spacer()
                    Text(isOperate ? valueTwo : isError ? "Error" : valueOne)
                        .bold()
                        .font(.title)
                        .lineLimit(1)
                }
                .padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 8) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(width: item.rawValue == "0" ? 190 : 90,
                                           height: 110, alignment: .center)
                                    .background(item.buttonColor)
                                    .foregroundColor(item == .clear ? .blue : item.rawValue == "=" ? .white : .black)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }

    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .mutliply, .divide:
            let newOp = button == .add ? "+" :
                       button == .subtract ? "-" :
                       button == .mutliply ? "×" : "÷"
            setOperator(newOp)
            
        case .equal:
            if isOperate {
                result = formatNumber(calculate(valueOne: valueOne, valueTwo: valueTwo, operate: operate))
                valueOne = result
                valueTwo = "0"
                isOperate = false
                operate = ""
            }
            
        case .clear:
            clear()
            result = "0"
            
        case .negative:
            toggleSign()
            
        case .percent:
            percent()
            
        case .decimal:
            appendDot()
            
        default:
            appendNumber(button.rawValue)
        }
    }
    
    func clear() {
        valueOne = "0"
        valueTwo = "0"
        operate = ""
        isOperate = false
        isError = false
    }
    
    func appendNumber(_ num: String) {
        if isOperate {
            if valueTwo == "0" && num != "." {
                valueTwo = num
            } else {
                valueTwo += num
            }
        } else {
            if valueOne == "0" && num != "." {
                valueOne = num
            } else {
                valueOne += num
            }
        }
    }
    
    func appendDot() {
        if isOperate {
            if !valueTwo.contains(".") {
                valueTwo = valueTwo == "0" ? "0." : valueTwo + "."
            }
        } else {
            if !valueOne.contains(".") {
                valueOne = valueOne == "0" ? "0." : valueOne + "."
            }
        }
    }
    
    func toggleSign() {
        if isOperate {
            if valueTwo.first == "-" {
                valueTwo.removeFirst()
            } else if valueTwo != "0" {
                valueTwo = "-" + valueTwo
            }
        } else {
            if valueOne.first == "-" {
                valueOne.removeFirst()
            } else if valueOne != "0" {
                valueOne = "-" + valueOne
            }
        }
    }
    
    func percent() {
        if let v2 = Double(valueTwo) {
            valueTwo = formatNumber(v2 / 100)
        }
        if let v1 = Double(valueOne) {
            valueOne = formatNumber(v1 / 100)
        }
    }
    
    func setOperator(_ newOp: String) {
        if isOperate, valueTwo != "0" {
            valueOne = formatNumber(calculate(valueOne: valueOne, valueTwo: valueTwo, operate: operate))
            result = valueOne
            valueTwo = "0"
        }
        operate = newOp
        isOperate = true
    }
    
    func calculate(valueOne: String, valueTwo: String, operate: String) -> Double {
        guard let value1 = Double(valueOne),
              let value2 = Double(valueTwo) else {
            return 0
        }
        switch operate {
        case "+": return value1 + value2
        case "-": return value1 - value2
        case "×": return value1 * value2
        case "÷":
            if value2 == 0 {
                isError = true
            }
        return value1 / value2
        default: return value1
        }
    }
    
    func formatNumber(_ number: Double) -> String {
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(number))
        } else {
            return String(number)
        }
    }
}

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

#Preview {
    ContentView()
}
