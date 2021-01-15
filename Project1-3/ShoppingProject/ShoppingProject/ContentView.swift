//
//  ContentView.swift
//  ShoppingProject
//
//  Created by Guruprasad Rao on 1/13/21.
//

import SwiftUI

struct ContentView: View {
   @State private var Username = ""
    @State private var Password = ""
   @State private var Purpose = 0
  
   let appPurposes = ["Browse","Buying", "WindowShopping"]
  
  
   var body: some View {
       NavigationView {
           Form {
            Section {
                Text("Welcome to Shopping with Swift, your one stop shop for swift rage.")
            }
            Section(header: Text("Username and Password:")) {
                   TextField("Username?", text : $Username)
                    .keyboardType(.alphabet)
                    TextField("Password?", text : $Password)
                    .keyboardType(.alphabet)
                   
               }
               Section(header: Text("Why are you on this app?")){
                   Picker("Purpose", selection : $Purpose){
                       ForEach(0 ..< appPurposes.count){
                           Text("\(self.appPurposes[$0])")
                       }
                   }
                   .labelsHidden()
               }
            
           }
           .navigationBarTitle("Shopping with Swift")
          
       }
      
   }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
