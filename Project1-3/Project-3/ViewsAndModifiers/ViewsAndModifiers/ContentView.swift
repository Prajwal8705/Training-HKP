//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Guruprasad Rao on 1/3/21.
//

import SwiftUI

struct TextMessage: View {
    var text: String
    
    var body: some View {
        Text(text)
            .padding()
            .font(.title3)
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}
struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundColor(Color.white)
                .padding(5)
                .background(Color.black)
                
        }
    }
}
extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}
struct CapsuleShape: ViewModifier {
    func body(content: Content) -> some View {
         content
            .padding()
            .font(.title3)
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}
struct Title: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.title3)
            .clipShape(Capsule())
    }
}
struct Title2: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.title2)
    }
}
struct Rectangle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
    }
}
extension View {
    func rectangle() -> some View {
        self.modifier(Rectangle())
    }
}
struct ContentView: View {
    var body: some View {
        VStack{
            Color.blue
                .frame(width: 300, height: 300)
                .watermarked(with: "Hacking with Swift")
            TextMessage(text: "Hello")
            Text("My name is ____")
                .rectangle()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
