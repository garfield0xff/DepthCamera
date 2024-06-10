//
//  RoomSessionManager.swift
//  ARSessionTesting
//
//  Created by Gyujin Kim on 4/9/24.
//

import Foundation
import RoomPlan
import SwiftUI
import ARKit
import RealityKit

class RoomCaptureSessionManager: SessionProtocol, RoomCaptureSessionDelegate {
    
    
    var view: RoomCaptureView?
    var session: RoomCaptureSession { return (view?.captureSession)! }
    var roomBuilder: RoomBuilder?
    var delegate: RoomCaptureViewDelegate?
    
    private var configuration: RoomCaptureSession.Configuration?
    
    init(_ view : RoomCaptureView) {
        self.view = view
        self.roomBuilder = RoomBuilder(options: [.beautifyObjects])
        
    }
    
    func configureSession() {
        let configuration = RoomCaptureSession.Configuration()
        self.configuration = configuration
    }
    
    func startSession() {
        view?.captureSession.run(configuration: self.configuration!)
    }
    
    func completeSession() {
        session.stop(pauseARSession: true)
    }
    
    func stopSession() {
        session.stop()
        removeSession()
    }
    
    func removeSession() {
        view?.removeFromSuperview()
        view = nil
    }
    
    func captureView(didPresent: CapturedRoom, error: Error?) {
        
    }
    
}

