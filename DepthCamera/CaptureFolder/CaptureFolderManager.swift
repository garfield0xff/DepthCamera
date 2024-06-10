//
//  CaptureFolderManager.swift
//  ARSessionTesting
//
//  Created by Gyujin Kim on 4/16/24.
//

import Foundation
import os
import ARKit

class CaptureFolderManager: ObservableObject {
    
    
    static let logger = Logger(subsystem: ARSessionTestingApp.subsystem, category: "CaptureFolderManager")
    
    private let logger = CaptureFolderManager.logger
    
    let rootCaptureFolder: URL
    
    init?() {
        guard let newFolder = CaptureFolderManager.createNewCaptureFolder() else {
            logger.error("Unable to create capture directory")
            return nil
        }
        
        rootCaptureFolder = newFolder
    }
    
    
    static func createNewCaptureFolder() -> URL? {
        guard let capturesFolder = rootCapturesFolder() else {
            logger.error("Cant't get user document dir!")
            return nil
        }
        
        let folderName = "OBJ_FILES"
        let folderURL = capturesFolder.appendingPathComponent(folderName)
        logger.log("Creating capture path: \"\(String(describing: folderURL))\"")
        
        do {
            try FileManager.default.createDirectory(atPath: folderURL.path, withIntermediateDirectories: true, attributes: nil)
        } catch {
            logger.error("Failed to create capturepath=\"\(folderURL.path)\" error=\(String(describing:error))")
            return nil
        }
        
        var isDir: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: folderURL.path, isDirectory: &isDir)
        guard exists && isDir.boolValue else {
            return nil
        }
        
        return folderURL
    }
    
    private static func rootCapturesFolder() -> URL? {
        guard let documentsFolder =
                try? FileManager.default.url(for: .documentDirectory,
                                             in: .userDomainMask,
                                             appropriateFor: nil, create: false) else {
            return nil
        }
        return documentsFolder.appendingPathComponent("Captures/", isDirectory: true)
    }
}
