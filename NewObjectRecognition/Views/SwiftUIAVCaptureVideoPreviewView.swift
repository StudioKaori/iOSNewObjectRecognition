//
//  SwiftUIAVCaptureVideoPreviewView.swift
//  NewObjectRecognition
//
//  Created by Kaori Persson on 2022-05-26.
//

import SwiftUI
import AVFoundation
import Vision

class UIAVCaptureVideoPreviewView: UIView, AVCaptureVideoDataOutputSampleBufferDelegate {
    // AVCaptureVideoDataOutputSampleBufferDelegate
    // when you want to handle the video input every second, you will add the delegate
    var recognitionInterval = 0 //Interval for object recognition
    
    var mlModel: VNCoreMLModel? // CoreML model
    
    var captureSession: AVCaptureSession!
    
    func setupSession() {
        captureSession = AVCaptureSession()
        captureSession.beginConfiguration()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else { return }
        guard captureSession.canAddInput(videoInput) else { return }
        captureSession.addInput(videoInput)
        
        let photoOutput = AVCapturePhotoOutput()
        guard captureSession.canAddOutput(photoOutput) else { return }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(photoOutput)
        
        captureSession.commitConfiguration()
        
    }
    
    func setupPreview() {
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        previewLayer.frame = self.frame
        
        self.layer.addSublayer(previewLayer)
        
        self.captureSession.startRunning()
    }
}

struct SwiftUIAVCaptureVideoPreviewView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIAVCaptureVideoPreviewView {
        let view = UIAVCaptureVideoPreviewView()
        view.setupSession()
        view.setupPreview()
        return view
    }
    
    func updateUIView(_ uiView: UIAVCaptureVideoPreviewView, context: Context) {
    }
}
