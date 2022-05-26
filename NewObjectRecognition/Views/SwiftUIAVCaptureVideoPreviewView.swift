//
//  SwiftUIAVCaptureVideoPreviewView.swift
//  NewObjectRecognition
//
//  Created by Kaori Persson on 2022-05-26.
//

import SwiftUI
import AVFoundation
import Vision

public class UIAVCaptureVideoPreviewView: UIView {
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

    }
}

public struct SwiftUIAVCaptureVideoPreviewView: UIViewRepresentable {

    public func makeUIView(context: Context) -> UIAVCaptureVideoPreviewView {
        let view = UIAVCaptureVideoPreviewView()
        view.setupSession()
        view.setupPreview()
        return view
    }
    
    public func updateUIView(_ uiView: UIAVCaptureVideoPreviewView, context: Context) {
    }
}
