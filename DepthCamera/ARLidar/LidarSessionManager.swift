//
//  ARSessionManager.swift
//  ARSessionTesting
//
//  Created by Gyujin Kim on 4/9/24.
//

import Foundation
import ARKit
import RealityKit

class LidarCaptureSessionManager: SessionProtocol {
    var view: ARView?
    var session: ARSession { return ( view?.session )! }
    
    private var configuration: ARWorldTrackingConfiguration?
    
    init(_ view: ARView) {
        self.view = view
    }
    
    
    func configureSession()  {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        self.configuration = configuration
        
        //Debugging Option
        setDebugOption()
        setCoachingOverlay()
        
    }
    
    func startSession() {
        guard let sessionConfig = self.configuration else {
            self.configuration = ARWorldTrackingConfiguration()
            self.session.run(self.configuration!)
            return
        }
        
        self.session.run(sessionConfig)
    }
    
    func stopSession() {
        self.session.pause()
        removeSession()
    }
    
    func removeSession() {
        view?.removeFromSuperview()
        view = nil
    }
    
    func completeSession() {
        self.session.pause()
    }
    
    // - MARK: Private Option
    
    private func setDebugOption() {
        #if DEBUG
        self.view?.debugOptions = [.showFeaturePoints]
        #endif
    }
    
    private func setCoachingOverlay() {
        let coachingOverlay = ARCoachingOverlayView()
        // 오토리사이징 대신에 오토레이아웃을 사용해 보정
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        self.view?.addSubview(coachingOverlay)
        
        NSLayoutConstraint.activate([
            coachingOverlay.topAnchor.constraint(equalTo: view!.topAnchor),
            coachingOverlay.bottomAnchor.constraint(equalTo: view!.bottomAnchor),
            coachingOverlay.leadingAnchor.constraint(equalTo: view!.leadingAnchor),
            coachingOverlay.trailingAnchor.constraint(equalTo: view!.trailingAnchor),
        ])
        
        coachingOverlay.session = self.session
        coachingOverlay.goal = .horizontalPlane
    }
    
}
