//
//  AppDataModel.swift
//  ARSessionTesting
//
//  Created by Gyujin Kim on 4/9/24.
//

import os
import RealityKit
import SwiftUI
import RoomPlan
import ARKit

class AppDataModel: ObservableObject, Identifiable {
    let logger = Logger(subsystem: ARSessionTestingApp.subsystem, category: "AppDataModel")
    
    static let instance = AppDataModel()
    
    @Published var sessionManager : SessionProtocol? {
        willSet {
            detachListeners()
        }
        didSet {
            guard sessionManager != nil else { return }
        }
    }
    
    @Published var modelState: ModelState = .notSet {
        didSet {
            logger.debug("didSet AppDataModels.ModelState to \(self.modelState)")
            
            if modelState != oldValue {
                performStateTransition(from: oldValue, to: modelState)
            }
        }
    }
    
    @Published var sessionState: SessionState = .notSet {
        didSet {
            logger.debug("didSet AppDataModels.SessionState to \(self.sessionState)")
        }
    }
    
    // - MARK: Private Interface
    private var tasks: [ Task<Void, Never> ] = []
    
    deinit {
        DispatchQueue.main.async {
            self.detachListeners()
        }
    }
    
    @MainActor
    private func attachListeners() {
        logger.debug("Attaching listeners...")
        guard let model = sessionManager else {
            fatalError("Logic Error")
        }
    }
    
    private func detachListeners() {
        logger.debug("Detaching listeners...")
        for task in tasks {
            task.cancel()
        }
        tasks.removeAll()
    }

    private func startNewCapture() -> Bool {
        logger.log("startNewCapture() called...")
        sessionManager?.configureSession()
        sessionManager?.startSession()
        return true
    }
    
    private func completeCapture() -> Bool {
        logger.log("capture completed")
        sessionManager?.completeSession()
        return true
    }
    
    private func reset() {
        logger.info("reset() called...")
        sessionManager?.removeSession()
        sessionManager = nil
    }
    
    private func pause() {
        logger.info("pause() called...")
        sessionManager?.completeSession()
    }
    
    private func onStateChanged(newState: ModelState) {
        logger.info("session switched to staete: \(String(describing: newState))")
        if case .completed = newState {
            logger.log("session moved to .completed state. Switch app model to reconstruction")
            modelState = .prepareToReconstruct
        }
    }
    
    private func startReconstruction() throws {
        logger.debug("startReconstruction() called")
        

    }
    
    
    private func performStateTransition(from fromState: ModelState, to toState: ModelState) {
        switch toState {
        case .notSet: break
            
        case .ready:
            guard startNewCapture() else {
                logger.error("Starting new capture failed")
                break
            }
        case .capturing: break
        case .prepareToReconstruct:
            pause()
        case .viewing: 
            break
        case .completed:
            guard completeCapture() else {
                logger.error("Complete capture failed")
                break
            }
        case .restart:
            reset()
        case .failed: break
        }
    }
    
    

}
