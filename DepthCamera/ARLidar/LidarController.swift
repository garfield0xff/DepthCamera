//
//  Item.swift
//  ARSessionTesting
//
//  Created by Gyujin Kim on 4/9/24.
//
import SwiftUI
import ARKit
import RealityKit
import FocusEntity

struct LidarController: UIViewRepresentable {
    @EnvironmentObject var appModel: AppDataModel
    
    func makeUIView(context: Context) -> ARView {
        
        let lidarCaptureView = ARView(frame: .zero)
        
        let sessionManager = LidarCaptureSessionManager(lidarCaptureView)
        
        
        DispatchQueue.main.async {
            self.appModel.sessionManager = sessionManager
            self.appModel.sessionState = .lidarCapture
            self.appModel.modelState = .ready
        }
        
        
        return lidarCaptureView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
}
