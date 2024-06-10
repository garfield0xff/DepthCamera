//
//  AppDataModel+State.swift
//  ARSessionTesting
//
//  Created by Gyujin Kim on 4/9/24.
//

import Foundation



extension AppDataModel {
    //CustomStringConvertible : return 형식이 Custom String 으로 변환됌
    enum ModelState: String, CustomStringConvertible {
        var description: String { rawValue }
        
        case notSet
        case ready
        case capturing
        case prepareToReconstruct
        case viewing
        case completed
        case restart
        case failed
        
    }
    
    enum SessionState: String, CustomStringConvertible {
        var description: String { rawValue }
        
        case notSet
        case objectCapture
        case roomCapture
        case lidarCapture
        
    }
}
