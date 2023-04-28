//
//  HomeView.swift
//  Rapid Recap
//
//  Created by Kartik Punia on 4/27/23.
//

import SwiftUI

struct File: Identifiable {
    let id = UUID()
    let name: String
    let data: Data
}

struct HomeView: View {
    @Binding var files: [File]
    @State private var searchText = ""
    
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
            VStack {
                List {
                    ForEach(files.filter {
                        searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(searchText)
                    }, id: \.id) { file in
                        HStack {
                            Image("Document")
                            Text(file.name)
                                .font(.headline)
                        }
                    }
                }
                .searchable(text: $searchText)
            }
            .navigationTitle("Home")
        }//End searchBar - Pasted in
        .colorScheme(scheme)//Dark mode
    }
}
