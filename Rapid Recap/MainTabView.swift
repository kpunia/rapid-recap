//
//  MainTabView.swift
//  Rapid Recap
//
//  Created by Kartik Punia on 4/27/23.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var files: [File] = []
    @State var darkMode: Bool = false

    var body: some View {
        TabView{
            HomeView(files: $files, darkMode: $darkMode)
                .tabItem {
                    Image("Home")
                    Text("Home")
                }
                
            UploadView(files: $files, darkMode: $darkMode)
                .tabItem {
                    Image("Upload")
                    Text("Upload")
                }
                    
            SettingsView(darkMode: $darkMode)
                .tabItem {
                    Image("Settings")
                    Text("Settings")
                }
        }
    }
}
