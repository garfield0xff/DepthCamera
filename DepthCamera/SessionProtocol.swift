//
//  SessionManager+P.swift
//  ARSessionTesting
//
//  Created by Gyujin Kim on 4/9/24.
//

import Foundation
import ARKit

protocol SessionProtocol {
    func startSession()
    func stopSession()
    func configureSession()
    func removeSession()
    func completeSession()
}

