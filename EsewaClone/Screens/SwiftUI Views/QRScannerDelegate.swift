//
//  QRScannerDelegate.swift
//  EsewaClone
//
//  Created by Alin Khatri on 26/06/2023.
//

import SwiftUI
import AVKit

class QRScannerDelegate: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metaObject = metadataObjects.first {
            guard let readableObject = metaObject as? AVMetadataMachineReadableCodeObject else { return }
            
            guard let scannedCode = readableObject.stringValue else { return }
            print(scannedCode)
        }
    }
}

