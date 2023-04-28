//
//  SettingsView.swift
//  Rapid Recap
//
//  Created by Kartik Punia on 4/27/23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var darkMode: Bool
    private var scheme: ColorScheme {
        if darkMode {
            return .dark
        } else {
            return .light
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Appearance")) {
                    Toggle(isOn: $darkMode) {
                        Text("Dark Mode")
                    }
                }
                
                Section(header: Text("Account")) {
                    Button(action: {
                        // Handle logout action
                    }) {
                        Text("Log out")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Settings")
        }
        .colorScheme(scheme)//Dark mode
    }
}
