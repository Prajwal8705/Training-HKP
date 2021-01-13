//
//  ContentView.swift
//  Challenge1
//
//  Created by Guruprasad Rao on 1/11/21.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var sleepAmount = 6.0
    @State private var coffeeDrank = 1
    @State private var date = defaultWakeTime
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
   
    var body: some View {

        NavigationView {
            Form{
                VStack(spacing: 60){
                    Text("When do you want to Wake Up?")
                        .font(.title3)
                    DatePicker("Enter a Time", selection: $date,  displayedComponents: [.hourAndMinute])
                        .labelsHidden()
                    Text("How much sleep do you need?")
                    Stepper(value: $sleepAmount, in: 1...11, step: 0.25){
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                    Text("How many cups of coffee do you need?")
                    Stepper(value: $coffeeDrank, in: 0...20){
                        if coffeeDrank == 1 {
                            Text("1 cup of coffee")
                        } else {
                            Text("\(coffeeDrank) cups of coffee")
                        }
                    }
                }
            }
            .navigationBarTitle("Hello")
            .navigationBarItems(trailing:
            Button(action: CalculateBedtime) {
                 Text("Calculate")
                                        
            }
            )
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    func CalculateBedtime() {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour,.minute], from: date)
        let hour = (components.hour ?? 0) * 60 * 60
        let min = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + min), estimatedSleep: sleepAmount, coffee: Double(coffeeDrank))
            let sleepTime = date - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your Ideal Bedtime Is "
        } catch {
            alertTitle = "Error"
            alertMessage = "Problem with predicting bedtime"
        }
        
        showingAlert = true
     }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

