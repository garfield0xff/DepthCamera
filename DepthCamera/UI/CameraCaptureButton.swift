//
//  CameraCaptureButton.swift
//  ARSessionTesting
//
//  Created by Gyujin Kim on 4/12/24.
//

import SwiftUI

struct CameraCaptureButton: View {
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.white, lineWidth: 4)
                .background(Circle().foregroundColor(.black))
                .frame(width: 70, height: 70)
            
            Circle()
                .strokeBorder(Color.white, lineWidth: 2)
                .background(Circle().foregroundColor(.white))
                .frame(width: 50, height: 50)
//                                .animation(.easeInOut(duration: 0.25), value: submittedExportRequest)
        }
    }
}

#Preview {
    CameraCaptureButton()
}
