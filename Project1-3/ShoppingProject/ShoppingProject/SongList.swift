//
//  List.swift
//  ShoppingProject
//
//  Created by Guruprasad Rao on 1/14/21.
//

import SwiftUI

struct Response: Codable {
    var message: String
    var token: String
}

struct Result: Codable {
    var username: String
    var password: String
}

struct SongList: View {
    @State private var UsernameAndPassword = Result(username: "",password: "")
    @State private  var response = ""
    @State private var showingWorked = false
    @State private var Purpose = 0
   
    let appPurposes = ["Browse","Buying", "WindowShopping"]
   
   
    var body: some View {
        NavigationView {
            Form {
             Section {
                 Text("Welcome to Shopping with Swift, your one stop shop for swift rage.")
             }
             Section(header: Text("Username and Password:")) {
                TextField("Username?", text : $UsernameAndPassword.username)
                     .keyboardType(.alphabet)
                     TextField("Password?", text : $UsernameAndPassword.password)
                     .keyboardType(.alphabet)
                    Button("Login"){
                        self.LoginAttempt()
                    }
                    .padding()
                
                    
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
            .alert(isPresented: $showingWorked) {
                Alert(title: Text("Login Status"), message: Text("\(response)!"), dismissButton: .default(Text("OK")))
            }
           
        }
       
    }
    func LoginAttempt() {
        guard let encoded = try? JSONEncoder().encode(UsernameAndPassword.self) else {
            print("Failed to encode username and password")
            return
        }
        guard let url = URL(string: "https://install-gentoo.herokuapp.com/users/login") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown Error")")
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Response.self, from: data) {
                
                self.response = decodedOrder.message
                self.showingWorked = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
        
    }
}

struct SongList_Previews: PreviewProvider {
    static var previews: some View {
        SongList()
    }
}
