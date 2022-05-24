//
//  ContentView.swift
//  MortgageCalculator
//
//  Created by Sebastian Hajduk on 24/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var purchasePrice = 0.0
    @State private var downPayment = 0.0
    @State private var repaymentTime = 0.0
    @State private var interestRate = 0.0
    @State private var estimatedMonthlyCost: Double?
    
//    var monthly: Double {
//        //Formula for mortgage payments: M = P[r(1+r)^n/((1+r)^n)-1)]
//        //M = the total monthly mortgage payment
//        //P = the principal loan amount(Purchase Price - Down Payment)
//        //r = your monthly interest rate
//        //n = number of payments over the loan’s lifetime.
//
//        let p = purchasePrice > downPayment ? purchasePrice - downPayment : 0
//        let r = interestRate / 12
//        let n = repaymentTime * 12
//
//        let m = p * (r * pow((1 + r), n) / (pow((1 + r), n) - 1))
//
//        estimatedMonthlyCost = m
//
//        return m
//    }
    
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Group {
                    Text("Purchase price: $\(purchasePrice, specifier: "%.0f")")
                    Slider(value: $purchasePrice, in: 150000...1500000, step: 1000) { editing in
                        isEditing = editing
                        if !isEditing {
                            calcMonthlyPayment()
                        }
                        
                    }
                    
                    Text("Down payment: $\(downPayment, specifier: "%.0f")")
                    Slider(value: $downPayment, in: 0...calcDownPayment(purchasePrice), step: 1000) { editing in
                        isEditing = editing
                        if !isEditing {
                            calcMonthlyPayment()
                        }
                    }
                    
                    Text("Repayment time: \(repaymentTime, specifier: "%.0f") years")
                    Slider(value: $repaymentTime, in: 3...50, step: 1) { editing in
                        isEditing = editing
                        if !isEditing {
                            calcMonthlyPayment()
                        }
                    }
                    
                    Text("Interest rate: \(interestRate, specifier: "%.1f")%")
                    Slider(value: $interestRate, in: 0.3...10, step: 0.1) { editing in
                        isEditing = editing
                        if !isEditing {
                            calcMonthlyPayment()
                        }
                    }
                }
                
                Group {
                    Text("Loan amount:")
                    Text("\(purchasePrice - downPayment)")
                    
                    Text("Estimated monthly payment")
                    Text("\(estimatedMonthlyCost ?? 0)")
                }
                
            }
            .padding(35)
        }
    }
    
    func calcMonthlyPayment() -> Double {
        
        if purchasePrice > 0 && downPayment > 0 && repaymentTime > 0 && interestRate > 0 {
            let p = purchasePrice > downPayment ? purchasePrice - downPayment : 0
            let r = interestRate / 100 / 12
            let n = repaymentTime * 12
            
            let m = p * (r * pow((1 + r), n) / (pow((1 + r), n) - 1))
            
            estimatedMonthlyCost = m
            
            return estimatedMonthlyCost ?? 0.0

        } else {
            return 0.0
        }
    }
    
    func calcDownPayment(_ homePrice: Double) -> Double {
        if homePrice != 0 {
            return purchasePrice * 0.3
        } else {
            return 500000.00
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
