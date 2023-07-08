//
//  ScanView.swift
//  EsewaClone
//
//  Created by Alin Khatri on 26/06/2023.
//

import SwiftUI
import AVKit

struct ScanView: View {
    
    @State private var session: AVCaptureSession = .init()
    @State var qrOutput: AVCaptureMetadataOutput = .init()
    @State var errorMessage: String = ""
    @State var showError: Bool = false
    
    @State private var cameraPermission: PermissionStatus = .idle
    
    @Environment(\.openURL) private var openURL
    @StateObject private var qrDelegate = QRScannerDelegate()
    
    var body: some View {
        VStack {
//            Button(action: {
//                
//            }) {
//                Image(systemName: "xmark")
//                    .font(.title3)
//                    .foregroundColor(Color.black)
//            }
//            .frame(maxWidth: .infinity, alignment: .trailing)
//            .padding(.horizontal)
            
            Text("Scan QR code to pay")
                .font(.headline)
            Image("FonePay")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width*0.3)
            
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "qrcode")
                        .font(.title2)
                        .foregroundColor(Color(uiColor: .label))
                    
                    Text("Add QR Code from gallery")
                        .foregroundColor(Color(uiColor: .label))
                }
                .padding()
                .overlay {
                    Rectangle()
                        .fill(.clear)
                        .border(.black)
                }
                
            }
            
            GeometryReader {
                let size = $0.size
                
                ZStack {
                    CameraView(frameSize: CGSize(width: size.width, height: size.height), session: $session)
                    
                    Rectangle()
                        .fill(.clear)
                        .border(Color(uiColor: UIColor(named: "EAccent")!), width: 3)
                }
                .frame(width: size.width, height: size.width)
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 45)
            .padding(.vertical, 10)
            
            Spacer(minLength: 15)
            


        }
        .padding(15)
        .onAppear(perform: checkCameraPermission)
        .alert(errorMessage, isPresented: $showError) {
            
            if cameraPermission == .denied {
                Button("Settings") {
                    let settingString = UIApplication.openSettingsURLString
                    
                    if let settingsURL = URL(string: settingString) {
                     openURL(settingsURL)
                    }
                }
                
                Button("Cancel", role: .cancel) {
                    
                }
            }
        }
    }
    
    // Check Camera Permission
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermission = .approved
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermission = .approved
                    setupCamera()
                } else {
                    cameraPermission = .denied
                    presentError("Please provide access to camer to scan QR code")
                }
            case .denied, .restricted:
                cameraPermission = .denied
                presentError("Please provide access to camer to scan QR code")
            default:
                break
            }
        }
    }
    
    func setupCamera() {
        do {
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInUltraWideCamera], mediaType: .video, position: .back).devices.first else {
                presentError("Unknown error. Please try again")
                return
            }
            
            let input = try AVCaptureDeviceInput(device: device)
            
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else {
                presentError("Unknown error. Please try again")
                return
            }
            
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            
            qrOutput.metadataObjectTypes = [.qr]
            
            qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
            session.commitConfiguration()
            
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            
        } catch {
            presentError(error.localizedDescription)
        }
    }
    
    func presentError(_ message: String) {
        errorMessage = message
        showError.toggle()
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
