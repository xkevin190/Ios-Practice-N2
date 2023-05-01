//
//  CameraViewModel.swift
//  TestMaking
//
//  Created by Kevin Velasco on 28/4/23.
//

import Foundation
import AVFoundation


class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    
    @Published var isTaken = false
    @Published var flash: Bool = false;
    @Published var openCamera: Bool = false;
    @Published var imagePicked: Data = Data(count: 0);
    
    
    @Published var sesion = AVCaptureSession();
    @Published var output = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!

    
    
    
    private var input: AVCaptureDeviceInput!
    private var device: AVCaptureDevice!
    
    
    @Published var backCamera: Bool = false
    
    
    func check () {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            self.sepUp()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                if status {
                    self.sepUp()
                }
            }
        case .denied:
            print("no tienes permiso")
            return
        default:
            return
        }
    }
    
    
    
    func SetBackCamera () {
        do {
            self.device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
            
            self.input = try AVCaptureDeviceInput(device: self.device!)
        }catch {
            print(error.localizedDescription)
        }
        
    }
    
    func setFronCamera () {
        do {
            self.device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            
            self.input = try AVCaptureDeviceInput(device: self.device!)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    
    func sepUp () {
        do {
            self.sesion.beginConfiguration()
            
            
            SetBackCamera()
            
            if self.sesion.canAddInput(self.input) {
                self.sesion.addInput(self.input)
            }
            
            if self.sesion.canAddOutput(self.output) {
                self.sesion.addOutput(self.output)
            }
            
            self.sesion.commitConfiguration()
            
        }
    }
    
    
    func ToogleFlash () {
        if self.device.hasTorch {
            do {
                try device.lockForConfiguration()
                device.torchMode =  flash ? .off : .on
                device.unlockForConfiguration()
                flash.toggle()
            } catch {
                print("Error activating flash: \(error.localizedDescription)")
            }
        } else {
            print("Flash not available")
        }
    }
    
    
    
    func toggleCamera() {
        backCamera.toggle()
        sesion.beginConfiguration()
        sesion.removeInput(self.input!)
        if (backCamera) {
            setFronCamera()
            self.sesion.addInput(self.input)
        } else {
            SetBackCamera()
            self.sesion.addInput(self.input)
        }
        sesion.commitConfiguration()
    }
    
    
    func TakePicture () {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }

    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if error != nil {
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else {return}
        
        imagePicked = imageData;
        
        self.sesion.stopRunning()
    }
}
