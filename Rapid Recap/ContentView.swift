//
//  ContentView.swift
//  Rapid Recap
//
//  Created by Kartik Punia on 4/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isMainTabViewActive = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.blue]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                Text("Rapid Recap")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding(.top, 30)
                
                Button("Tap to Begin!"){
                    isMainTabViewActive.toggle()
                }
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.top, 30)
                    .fullScreenCover(isPresented: $isMainTabViewActive, content: {
                        MainTabView()
                    })
            }
        }
    }
}
