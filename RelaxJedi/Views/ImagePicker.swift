//
//  Test.swift
//  RelaxJedi
//
//  Created by Alexandre Bomfim on 06/12/22.
//

import PhotosUI
import SwiftUI

struct ImagePicker:UIViewControllerRepresentable{

    func makeUIViewController(context: Context) -> some UIViewController {
        let next = CameraViewController()
        return next
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }

}
