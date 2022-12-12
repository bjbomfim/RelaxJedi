//
//  Test.swift
//  RelaxJedi
//
//  Created by Alexandre Bomfim on 06/12/22.
//

import SwiftUI

struct ImagePicker:UIViewControllerRepresentable{
    var pointsProcessorHandler: (([CGPoint]) -> Void)?

    func makeUIViewController(context: Context) -> CameraViewController {
      let cvc = CameraViewController()
      cvc.pointsProcessorHandler = pointsProcessorHandler
      return cvc
    }

    func updateUIViewController(
      _ uiViewController: CameraViewController,
      context: Context
    ) {
    }
}
