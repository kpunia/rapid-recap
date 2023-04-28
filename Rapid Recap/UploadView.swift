//
//  UploadView.swift
//  Rapid Recap
//
//  Created by Kartik Punia on 4/27/23.
//

import SwiftUI

struct UploadView: View {
    @State private var isShowingFilePicker = false
    @Binding var files: [File]
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
                Button("Select File") {
                    isShowingFilePicker = true
                }
                .padding()
                
                .fileImporter(
                    isPresented: $isShowingFilePicker,
                    allowedContentTypes: [.pdf],
                    onCompletion: { result in
                        if case .success(let url) = result {
                            do {
                                let data = try Data(contentsOf: url)
                                addFile(file: data)
                            } catch {
                                print("Error reading file: \(error.localizedDescription)")
                            }
                        }
                    }
                )//End fileImporter - Pasted in
            }
            .navigationTitle("Upload")
        }
        .colorScheme(scheme)//Dark mode
    }
    func addFile(file: Data) {
        let newFile = File(name: "file" + String(files.count + 1), data: file)
        files.append(newFile)
    }
}
