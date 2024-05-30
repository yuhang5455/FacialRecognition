//
//  FaceRecognitionViewController.swift
//  FacialRecognitionSwift
//
//  Created by 于航 on 2024/5/30.
//

import UIKit
import AVFoundation
import Vision

class FaceRecognitionViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var previewLayer: AVCaptureVideoPreviewLayer!
    var captureSession: AVCaptureSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "人脸识别"
        // 设置捕获会话
        captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
        } catch {
            print(error)
            return
        }
        
        // 设置预览图层
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        // 设置输出
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(videoOutput)
        
        // 开始捕获
        captureSession.startRunning()
    }
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        // 创建人脸检测请求
        let request = VNDetectFaceRectanglesRequest { (request, error) in
            if let error = error {
                print("Failed to detect faces:", error)
                return
            }
            
            guard let results = request.results as? [VNFaceObservation] else { return }
            
            for result in results {
                print("打印:\(result.boundingBox.width - result.boundingBox.height)")
                
                if abs(result.boundingBox.width - result.boundingBox.height) < 0.2 {
                    print("Detected a front-facing face")
                }
//                if result.confidence > 0.5 { // 置信度大于0.5表示检测到了人脸
//                    print("Detected a face")
//                }
            }
        }
        
        // 执行人脸检测请求
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }

}
