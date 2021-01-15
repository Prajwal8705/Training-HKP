//
//  Checkout.swift
//  ShoppingProject
//
//  Created by Guruprasad Rao on 1/13/21.
//

import Foundation
import SwiftUI

struct Checkout: View {
   @State private var checkAmount = ""
   @State private var numberOfPeople = 0
   @State private var tipPercentage = 2
  
   let tipPercentages = [10, 15, 20, 25, 0]
  
   var totalPerPerson: Double {
       let peopleCount = Double(numberOfPeople + 2)
       let tipSelection = Double(tipPercentages[tipPercentage])
       let orderAmount = Double(checkAmount) ?? 0
      
       let grandTotal = orderAmount * (1 + (tipSelection/100))
       let amountPerPerson = grandTotal / peopleCount
       return amountPerPerson
      
   }
  
   var body: some View {
       NavigationView {
           Form {
               Section {
                   TextField("Amount", text : $checkAmount)
                       .keyboardType(.decimalPad)
                   Picker("What is the Number of People?", selection : $numberOfPeople){
                       ForEach(2 ..< 100){
                           Text(" \($0) people")
                       }
                   }
               }
               Section(header: Text("What tip Percentage would you Like?")){
                   Picker("What Tip Percentage?", selection : $tipPercentage){
                       ForEach(0 ..< tipPercentages.count){
                           Text("\(self.tipPercentages[$0])%")
                       }
                   }
                   .pickerStyle(SegmentedPickerStyle())
               }
               Section {
                   Text("Total Amount Per Person is $\(String(format: "%.2f",totalPerPerson))")
               }
           }
           .navigationBarTitle("WeSplit")
          
       }
      
   }
}

struct Checkout_Previews: PreviewProvider {
    static var previews: some View {
        Checkout()
    }
}
