//
//  CameraView.swift
//  RelaxJedi
//
//  Created by Alexandre Bomfim on 07/12/22.
//

import UIKit
import AVFoundation

final class CameraView: UIView {
  var previewLayer: AVCaptureVideoPreviewLayer {
    return layer as! AVCaptureVideoPreviewLayer
  }

  override class var layerClass: AnyClass {
    AVCaptureVideoPreviewLayer.self
  }
}
