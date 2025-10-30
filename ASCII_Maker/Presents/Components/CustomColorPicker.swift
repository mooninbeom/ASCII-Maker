//
//  CustomColorPicker.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/30/25.
//

import SwiftUI



struct CustomColorPicker: UIViewControllerRepresentable {
    let title: String
    let action: (UIColor) -> Void
    
    func makeUIViewController(context: Context) -> UIColorPickerViewController {
        let view = UIColorPickerViewController()
        view.delegate = context.coordinator
        view.title = title
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        .init(action: action)
    }
    
    
    final class Coordinator: NSObject, UIColorPickerViewControllerDelegate {
        let action: (UIColor) -> Void
        
        init(action: @escaping (UIColor) -> Void) {
            self.action = action
        }
        
        func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
            self.action(color)
        }
    }
}




