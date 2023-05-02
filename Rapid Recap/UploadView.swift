//
//  UploadView.swift
//  Rapid Recap
//
//  Created by Kartik Punia on 4/27/23.
//

import SwiftUI
import OpenAI
import PDFKit

//Page where you upload files
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
    }//Handles dark mode
    
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
                                DispatchQueue.main.async {
                                    addFile(file: data)
                                }
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
    
    //Adds file to files in HomeView
    func addFile(file: Data) {
        let fileContents = extractTextFromPDF(file: file)
        
        if !fileContents.isEmpty {
            print("Entering generateNotes")
            generateNotes(fileContents: fileContents) { notes in
                print("Notes generated: \(notes)")
                let newFile = File(name: "File" + String(files.count + 1), data: file, notes: notes)
                files.append(newFile)
            }
        }
    }
    
    //Calls gpt API to generate notes
    func generateNotes(fileContents: String, completion: @escaping (String) -> Void) {
        let client = OpenAI(apiToken: "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")

        let prompt = "Create notes on the following text:\n\n" + fileContents
        let model = "text-davinci-002"
        let maxTokens = 64
        
        let query = CompletionsQuery(model: model, prompt: prompt, maxTokens: maxTokens)
        client.completions(query: query) { result in
            switch result {
            case .success(let completionResult):
                let notes = completionResult.choices.first?.text ?? ""
                completion(notes)
            case .failure(let error):
                print("Error: \(error)")
                completion("")
            }
        }
    }
    
    //Gets text from a PDF and turns it into String
    func extractTextFromPDF(file: Data) -> String {
        guard let pdf = PDFDocument(data: file) else {
            print("Failed to create PDF document")
            return ""
        }
        
        var extractedText = ""
        
        for pageIndex in 0..<pdf.pageCount {
            if let page = pdf.page(at: pageIndex) {
                if let pageText = page.string {
                    extractedText += pageText
                }
            }
        }
        
        return extractedText
    }
}
