//
//  ContentView.swift
//  MortgageCalculator
//
//  Created by Sebastian Hajduk on 24/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var purchasePrice = 150000.0
    @State private var downPayment = 0.0
    @State private var repaymentTime = 3.0
    @State private var interestRate = 0.3
    @State private var estimatedMonthlyCost: Double?
    
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Group {
                    Text("Purchase price: $\(purchasePrice, specifier: "%.0f")")
                    Slider(value: $purchasePrice, in: 150000...1500000, step: 1000) { editing in
                        isEditing = editing
                        
                        if purchasePrice < downPayment {
                            updateDownPayment()
                        }
                        
                        if !isEditing {
                            calcMonthlyPayment()
                        } else {
                            estimatedMonthlyCost = 0.0
                        }
                        
                    }
                    .tint(.purple.opacity(0.2))
                    .shadow(color: .purple.opacity(0.5), radius: 5)
                    
                    
                    Text("Down payment: $\(downPayment, specifier: "%.0f")")
                    Slider(value: $downPayment, in: 0...calcDownPayment(purchasePrice), step: 1000) { editing in
                        isEditing = editing
                        if !isEditing {
                            calcMonthlyPayment()
                        } else {
                            estimatedMonthlyCost = 0.0
                        }
                    }
                    .tint(.purple.opacity(0.2))
                    .shadow(color: .purple.opacity(0.5), radius: 5)
                    
                    Text("Repayment time: \(repaymentTime, specifier: "%.0f") years")
                    Slider(value: $repaymentTime, in: 3...50, step: 1) { editing in
                        isEditing = editing
                        if !isEditing {
                            calcMonthlyPayment()
                        } else {
                            estimatedMonthlyCost = 0.0
                        }
                    }
                    .tint(.purple.opacity(0.2))
                    .shadow(color: .purple.opacity(0.5), radius: 5)
                    
                    Text("Interest rate: \(interestRate, specifier: "%.1f")%")
                    Slider(value: $interestRate, in: 0.3...10, step: 0.1) { editing in
                        isEditing = editing
                        if !isEditing {
                            calcMonthlyPayment()
                        } else {
                            estimatedMonthlyCost = 0.0
                        }
                    }
                    .tint(.purple.opacity(0.2))
                    .shadow(color: .purple.opacity(0.5), radius: 5)
                }
                
                Group {
                    Text("Loan amount:")
                    Text("$\((purchasePrice - downPayment), specifier: "%.0f")")
                        .bold()
                    
                    Text("Estimated monthly payment:")
                    Text("$\(estimatedMonthlyCost ?? 0, specifier: "%.0f")")
                        .bold()
                        .font(.largeTitle)
                        .animation(.default, value: estimatedMonthlyCost)
                }
                
                
                
            }
            .foregroundColor(.purple)
            .padding(35)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .clipped()
            .shadow(color: .purple.opacity(0.5), radius: 10)
            .padding()
            .navigationBarTitle("Mortgage Calculator")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    
    func calcMonthlyPayment() {
        if purchasePrice > 0 && downPayment > 0 && repaymentTime > 0 && interestRate > 0 {
            let p = purchasePrice > downPayment ? purchasePrice - downPayment : 0
            let r = interestRate / 100 / 12
            let n = repaymentTime * 12
            
            let m = p * (r * pow((1 + r), n) / (pow((1 + r), n) - 1))
            
            estimatedMonthlyCost = m
        }
        
    }
    
    func calcDownPayment(_ homePrice: Double) -> Double {
        if homePrice != 0 {
            return purchasePrice * 0.3
        } else {
            return 500000.00
        }
    }
    
    func updateDownPayment() {
        
        downPayment = purchasePrice * 0.3
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
