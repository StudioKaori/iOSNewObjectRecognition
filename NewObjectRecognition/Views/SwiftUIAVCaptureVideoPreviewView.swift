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
    
    var resultLabel: UILabel!
    
    func setModel() {
        
        // create instance, model property
        mlModel = try? VNCoreMLModel(for: MobileNetV2().model)
    }
    
    func setupSession() {
        captureSession = AVCaptureSession()
        captureSession.beginConfiguration()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else { return }
        guard captureSession.canAddInput(videoInput) else { return }
        captureSession.addInput(videoInput)
        
        // Output settings
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "VideoQueue")) // set delegate to receive the data every frame
        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
        }
        
        captureSession.commitConfiguration()
        
    }
    
    func setupPreview() {
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        previewLayer.frame = self.frame
        
        self.layer.addSublayer(previewLayer)
        
        
        resultLabel = UILabel()
        resultLabel.text = "Swift"
        resultLabel.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        resultLabel.textColor = UIColor.red
        resultLabel.backgroundColor = UIColor.blue
        
        self.addSubview(resultLabel)
        
        
        self.captureSession.startRunning()
    }
    
    // caputureOutput will be called for each frame was written
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        // Recognise the object every 20 frames
        if recognitionInterval < 20 {
            recognitionInterval += 1
            return
        }
        recognitionInterval = 0
        
        
        // Convert CMSampleBuffer(an object holding media data) to CMSampleBufferGetImageBuffer
        guard
            let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer),
            let model = mlModel // Unwrap the mlModel
        else { return }
        
        // Create image process request, pass model and result
        let request = VNCoreMLRequest(model: model) { //An image analysis request that uses a Core ML model to process images.
            
            (request: VNRequest, error: Error?) in
            
            // Get results as VNClassificationObservation array
            guard let results = request.results as? [VNClassificationObservation] else { return }
            
            // top 5 results
            var displayText = ""
            for result in results.prefix(5) {
                displayText += "\(Int(result.confidence * 100))%" + result.identifier + "\n"
            }
            
            print(displayText)
            // Execute it in the main thread
            DispatchQueue.main.async {
                self.resultLabel.text = displayText
            }
        }
        
        // Execute the request
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
}

struct SwiftUIAVCaptureVideoPreviewView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIAVCaptureVideoPreviewView {
        let view = UIAVCaptureVideoPreviewView()
        view.setModel()
        view.setupSession()
        view.setupPreview()
        return view
    }
    
    func updateUIView(_ uiView: UIAVCaptureVideoPreviewView, context: Context) {
    }
}
