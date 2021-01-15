//
//  ShoppingProjectApp.swift
//  ShoppingProject
//
//  Created by Guruprasad Rao on 1/13/21.
//

import SwiftUI

@main
struct ShoppingProjectApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView{
                    ContentView()
                }
                .tabItem {
                    Image(systemName: "paperplane.fill")
                    Text("Login / Signup")
                }
                NavigationView{
                    Checkout()
                }
                .tabItem {
                    Image(systemName: "trash.fill")
                    Text("Checkout")
                }
            }
        }
    }
}
