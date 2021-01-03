//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Guruprasad Rao on 1/2/21.
//

import SwiftUI

struct ContentView: View {
    @ State private var countries = ["estonia", "france", "germany", "ireland", "italy", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()
    
    @State private var flagStatus = false
    @State private var scoreTitle = ""
    @State private var choiceIndex = Int.random(in: 0..<4)
    @State private var score = 0
    @State private var wrongAns = 0
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing: 30){
            
                VStack(spacing: 20){
                    Text("Tap the flag of")
                        .foregroundColor(Color.white)
                    Text(countries[choiceIndex].uppercased())
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<4){ number in
                    Button(action: {
                        self.FlagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                    
                }
                Spacer()
            }
            if flagStatus == true {
                Text("Your score is ")
            }
        }
        .alert(isPresented: $flagStatus) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score) / \(score + wrongAns)"), dismissButton: .default(Text("Continue")) {
                self.AskQuestion()
                }
            )
        }
    }
    func FlagTapped(_ number: Int){
        if number == choiceIndex {
            scoreTitle = "correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            wrongAns += 1
        }
        flagStatus = true
    }
    func AskQuestion() {
        countries.shuffle()
        choiceIndex = Int.random(in: 0..<3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
