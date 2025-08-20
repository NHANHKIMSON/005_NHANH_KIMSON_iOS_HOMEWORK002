//
//  ContentView.swift
//  Calculator_HomeWork
//
//  Created by Apple on 8/13/25.
//

import SwiftUI

struct ContentView: View {
    @State var valueOne: String = "0"
    @State var valueTwo: String = "0"
    @State var result: String = "0.00"
    @State var operate: String = ""
    @State var isOperate: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Text(result)
                Spacer()
                Text("\(operate)")
            }
            .multilineTextAlignment(.trailing)
            .padding()
            .font(.title2)
            .foregroundStyle(.red)
            Spacer()
            HStack{
                Spacer()
                Text("\(isOperate ? valueTwo : valueOne)")
                    .font(.title)
                    .padding()
            }
            HStack{
                Button(action: {clear(); result = "0.00"}){CalculatorButton(key: "C")}
                Button(action: {toggleSign()}){CalculatorButton(key: "+/-")}
                Button(action: {percent()}){CalculatorButton(key: "%")}
                Button(action: {setOperator("÷")}){CalculatorButton(key: "÷")}
            }
            HStack{
                Button(action: {appendNumber("7")}){CalculatorButton(key: "7")}
                Button(action: {appendNumber("8")}){CalculatorButton(key: "8")}
                Button(action: {appendNumber("9")}){CalculatorButton(key: "9")}
                Button(action: {setOperator("×")}){CalculatorButton(key: "×")}
            }
            HStack{
                Button(action: {appendNumber("4")}){CalculatorButton(key: "4")}
                Button(action: {appendNumber("5")}){CalculatorButton(key: "5")}
                Button(action: {appendNumber("6")}){CalculatorButton(key: "6")}
                Button(action: {setOperator("-")}){CalculatorButton(key: "-")}
            }
            HStack{
                Button(action: {appendNumber("1")}){CalculatorButton(key: "1")}
                Button(action: {appendNumber("2")}){CalculatorButton(key: "2")}
                Button(action: {appendNumber("3")}){CalculatorButton(key: "3")}
                Button(action: {setOperator("+")}){CalculatorButton(key: "+")}
            }
            HStack{
                Button(action: {appendNumber("0")}){
                    Text("0")
                        .frame(width: 190, height: 110)
                        .foregroundStyle(.black)
                        .font(.system(size: 40))
                        .background(Color(.systemGray6).opacity(0.6))
                }
                Button(action: {appendDot()}){CalculatorButton(key: ".")}
                Button(action: {
                    if isOperate {
                        result = String(calculate(valueOne: valueOne, valueTwo: valueTwo, operate: operate))
                        valueOne = result
                        valueTwo = "0"
                        isOperate = false
                        operate = ""
                    }
                }){CalculatorButton(key: "=")}
            }
        }
        .padding(.bottom)
    }
    
        
    func clear(){
        valueOne = "0"
        valueTwo = "0"
        operate = ""
        isOperate = false
    }
    
    func CalculatorButton(key: String) -> some View{
        Text(key)
            .frame(width: 90, height: 110)
            .foregroundStyle(.black)
            .background(Color(.systemGray6).opacity(0.6))
            .font(.system(size: 40))
    }
    
    func appendNumber(_ num: String){
        if isOperate {
            if valueTwo == "0" { valueTwo = num }
            else { valueTwo += num }
        } else {
            if valueOne == "0" { valueOne = num }
            else { valueOne += num }
        }
    }
    
    func appendDot(){
        if isOperate {
            if !valueTwo.contains(".") { valueTwo += "." }
        } else {
            if !valueOne.contains(".") { valueOne += "." }
        }
    }
    
    func toggleSign(){
        if isOperate {
            if valueTwo.first == "-" { valueTwo.removeFirst() }
            else if valueTwo != "0" { valueTwo = "-" + valueTwo }
        } else {
            if valueOne.first == "-" { valueOne.removeFirst() }
            else if valueOne != "0" { valueOne = "-" + valueOne }
        }
    }
    
    func percent(){
        if isOperate {
            if let v2 = Double(valueTwo) { valueTwo = String(v2 / 100) }
        } else {
            if let v1 = Double(valueOne) { valueOne = String(v1 / 100) }
        }
    }
    func setOperator(_ newOp: String){
        if isOperate, valueTwo != "0" {
            valueOne = String(calculate(valueOne: valueOne, valueTwo: valueTwo, operate: operate))
            result = valueOne
            valueTwo = "0"
        }
        operate = newOp
        isOperate = true
    }
    
    func calculate(valueOne: String, valueTwo: String, operate: String ) -> Double{
        guard let value1 = Double(valueOne),
              let value2 = Double(valueTwo) else {
            return 0
        }
        switch operate {
        case "+": return value1 + value2
        case "-": return value1 - value2
        case "×": return value1 * value2
        case "÷": return value2 != 0 ? value1 / value2 : 0
        default: return value1
        }
    }
}

#Preview {
    ContentView()
}
