//
//  HomeView.swift
//  Rapid Recap
//
//  Created by Kartik Punia on 4/27/23.
//

import SwiftUI

//File struct
struct File: Identifiable {
    let id = UUID()
    let name: String
    let data: Data
    let notes: String
}

//Homepage - Lists all the files
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
    }//Handles dark mode
    
    @State private var selectedFile: File?

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
                            Spacer()
                            Button(action: {
                                selectedFile = file
                            }, label: {
                                Image(systemName: "info.circle")
                            })
                        }
                    }
                    .onDelete(perform: deleteFile)
                }
                .searchable(text: $searchText)
                .sheet(item: $selectedFile) { file in
                    NotesView(file: file)
                }
            }//End search bar - pasted in
            .navigationTitle("Home")
        }
        .colorScheme(scheme)
    }
    
    private func deleteFile(at offsets: IndexSet) {
            files.remove(atOffsets: offsets)
    }//Delete file helper function
}

//Displays the notes
struct NotesView: View {
    let file: File
    
    var body: some View {
        VStack {
            Text("Notes for \(file.name)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                Text(file.notes)
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                    .padding(.horizontal)
            }
        }
    }
}
