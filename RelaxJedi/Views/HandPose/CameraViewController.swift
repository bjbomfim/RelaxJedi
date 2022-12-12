//
//  CameraViewController.swift
//  RelaxJedi
//
//  Created by Alexandre Bomfim on 07/12/22.
//

import UIKit
import AVFoundation
import Vision

final class CameraViewController: UIViewController {
    // swiftlint:disable:next force_cast
    private var cameraView: CameraView { view as! CameraView }
    private var cameraFeedSession: AVCaptureSession?
    private var lastObservationTimestamp = Date()
    
    private let videoDataOutputQueue = DispatchQueue(
        label: "CameraFeedOutput",
        qos: .userInteractive
    )
    
    private let handPoseRequest: VNDetectHumanHandPoseRequest = {
        let request = VNDetectHumanHandPoseRequest()
        request.maximumHandCount = 1
        return request
    }()
    
    var pointsProcessorHandler: (([CGPoint]) -> Void)?
    
    override func loadView() {
        view = CameraView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        do {
            if cameraFeedSession == nil {
                cameraView.previewLayer.videoGravity = .resizeAspectFill
                try setupAVSession()
                cameraView.previewLayer.session = cameraFeedSession
            }
            cameraFeedSession?.startRunning()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cameraFeedSession?.stopRunning()
        super.viewWillDisappear(animated)
    }
    
    func setupAVSession() throws {
        // Select a front facing camera, make an input.
        guard let videoDevice = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .front)
        else {
            throw AppError.captureSessionSetup(
                reason: "Could not find a front facing camera."
            )
        }
        
        guard let deviceInput = try? AVCaptureDeviceInput(
            device: videoDevice
        ) else {
            throw AppError.captureSessionSetup(
                reason: "Could not create video device input."
            )
        }
        
        let session = AVCaptureSession()
        session.beginConfiguration()
        session.sessionPreset = AVCaptureSession.Preset.high
        
        // Add a video input.
        guard session.canAddInput(deviceInput) else {
            throw AppError.captureSessionSetup(
                reason: "Could not add video device input to the session"
            )
        }
        session.addInput(deviceInput)
        
        let dataOutput = AVCaptureVideoDataOutput()
        if session.canAddOutput(dataOutput) {
            session.addOutput(dataOutput)
            // Add a video data output.
            dataOutput.alwaysDiscardsLateVideoFrames = true
            dataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        } else {
            throw AppError.captureSessionSetup(
                reason: "Could not add video data output to the session"
            )
        }
        session.commitConfiguration()
        cameraFeedSession = session
    }
    
    func processPoints(_ indexTip: CGPoint?, _ middleTip: CGPoint?, _ ringTip: CGPoint?,_ littleTip: CGPoint?) {
        // Convert points from AVFoundation coordinates to UIKit coordinates.
        guard let middleTip = middleTip, let indexPoint = indexTip, let ringTip = ringTip, let littleTip = littleTip else {
            if Date().timeIntervalSince(lastObservationTimestamp) > 2 {
                pointsProcessorHandler?([CGPoint(x: CGFloat(0), y: CGFloat(0)), CGPoint(x: CGFloat(0), y: CGFloat(0)), CGPoint(x: CGFloat(0), y: CGFloat(0)), CGPoint(x: CGFloat(0), y: CGFloat(0))])
            }
            return
        }
        let previewLayer = cameraView.previewLayer
        let indexPointConverted = previewLayer.layerPointConverted(fromCaptureDevicePoint: indexPoint)
        let middlePointConverted = previewLayer.layerPointConverted(fromCaptureDevicePoint: middleTip)
        let ringPointConverted = previewLayer.layerPointConverted(fromCaptureDevicePoint: ringTip)
        let littlePointConverted = previewLayer.layerPointConverted(fromCaptureDevicePoint: littleTip)
        pointsProcessorHandler?([indexPointConverted, middlePointConverted, ringPointConverted, littlePointConverted])
    }
}

extension
CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        var indexTip: CGPoint?
        var middleTip: CGPoint?
        var ringTip: CGPoint?
        var littleTip: CGPoint?
        
        defer {
            DispatchQueue.main.sync {
                self.processPoints(indexTip, middleTip, ringTip, littleTip)
            }
        }
        
        let handler = VNImageRequestHandler(
            cmSampleBuffer: sampleBuffer,
            orientation: .up,
            options: [:]
        )
        do {
            // Perform VNDetectHumanHandPoseRequest
            try handler.perform([handPoseRequest])
            
            // Continue only when at least a hand was detected in the frame. We're interested in maximum of two hands.
            guard let results = handPoseRequest.results?.first
            else {
                return
            }
            
            let indexFingerPoints = try results.recognizedPoints(.indexFinger)
            let middleFingerPoints = try results.recognizedPoints(.middleFinger)
            let ringFingerPoints = try results.recognizedPoints(.ringFinger)
            let littleFingerPoints = try results.recognizedPoints(.littleFinger)
            
            guard let indexTipPoint = indexFingerPoints[.indexTip], let middleTipPoint = middleFingerPoints[.middleTip], let ringTipPoint = ringFingerPoints[.ringTip], let littleTipPoint = littleFingerPoints[.littleTip] else {
                return
            }
            // Ignore low confidence points.
            guard indexTipPoint.confidence > 0.3 && middleTipPoint.confidence > 0.3 && ringTipPoint.confidence > 0.3 && littleTipPoint.confidence > 0.3 else {
                return
            }
            
        indexTip = CGPoint(x: indexTipPoint.location.x, y: 1 - indexTipPoint.location.y)
        middleTip = CGPoint(x: middleTipPoint.location.x, y: 1 - middleTipPoint.location.y)
        ringTip = CGPoint(x: ringTipPoint.location.x, y: 1 - ringTipPoint.location.y)
        littleTip = CGPoint(x: littleTipPoint.location.x, y: 1 - littleTipPoint.location.y)

            
        } catch {
            cameraFeedSession?.stopRunning()
            print(error.localizedDescription)
        }
    }
}
