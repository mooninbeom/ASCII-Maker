//
//  UIImage +.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/20/25.
//

import UIKit


extension UIImage {
    public func resizePixel(to size: CGSize) -> UIImage? {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        
        let renderer = UIGraphicsImageRenderer(
            size: size,
            format: format
        )
        return renderer.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
