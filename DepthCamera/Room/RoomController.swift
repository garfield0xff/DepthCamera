//
//  RoomController.swift
//  ARSessionTesting
//
//  Created by Gyujin Kim on 4/10/24.
//

import SwiftUI
import RoomPlan

struct RoomController: UIViewRepresentable {
    @EnvironmentObject var appModel : AppDataModel
    
    func makeUIView(context: Context) -> some RoomCaptureView {
        let roomCaptureView = RoomCaptureView(frame: .zero)
        let sessionManager = RoomCaptureSessionManager(roomCaptureView)
        
        DispatchQueue.main.async {
            self.appModel.sessionManager = sessionManager
            self.appModel.sessionState = .roomCapture
            self.appModel.modelState = .ready
        }
        
        return roomCaptureView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#Preview {
    RoomController()
}
