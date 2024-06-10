//
//  FetchModel.swift
//  ARSessionTesting
//
//  Created by Gyujin Kim on 4/16/24.
//

import SwiftUI

struct FetchModelView: View {
    @State private var fileNames: [String] = []
    @State private var fullScreen = false
    
    var body: some View {
        VStack {
            List(self.fileNames, id: \.self) { fileName in
                Button(action: {
                    self.fullScreen.toggle()
                }) {
                    HStack {
                        Text(fileName)
                        Spacer()
                        Image(systemName: "eye.fill")
                    }
                }
                .swipeActions(edge: .trailing) {
                        
                }
            }
            .refreshable {
                fetchFiles()
            }
            .fullScreenCover(isPresented: $fullScreen) {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                    
                }
            }
            
        }.onAppear() {
            fetchFiles()
        }
    }
    
    func fetchFiles() {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let folderName = "OBJ_FILES"
        let folderURL = documentsDirectory.appendingPathExtension(folderName)
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
            let filteredURLs = fileURLs.filter { (url) -> Bool in
                return url.pathExtension == "obj"
            }
            
            self.fileNames = filteredURLs.map { $0.lastPathComponent }
        } catch {
            print("Error fetching files: \(error)")
        }
    }
    
    
    
}

#Preview {
    FetchModelView()
}
