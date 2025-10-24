//
//  UIImage +.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/20/25.
//

import UIKit


extension UIImage {
    public func resizeImage(to size: CGSize) -> UIImage {
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

// MARK: - 이미지 배경 추출 메소드(누끼)
import Vision
import CoreImage


extension UIImage {
    public func removeBackground() async throws -> UIImage {
        let ciImage: CIImage = try {
            if self.ciImage == nil {
                if self.cgImage != nil {
                    return CIImage(cgImage: self.cgImage!)
                } else {
                    throw NSError()
                }
            } else {
                return self.ciImage!
            }
        }()
        
        let request = VNGenerateForegroundInstanceMaskRequest()
        let handler = VNImageRequestHandler(
            ciImage: ciImage,
            orientation: .init(uiImageOrientation: self.imageOrientation)
        )
        
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<UIImage, any Error>) in
            Task(priority: .background) {
                do {
                    try handler.perform([request])
                } catch {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let result = request.results?.first else {
                    print("No subject observations found, Return origianl one")
                    continuation.resume(throwing: NSError())
                    return
                }
                
                
                let maskedImage = try result.generateMaskedImage(
                    ofInstances: result.allInstances,
                    from: handler,
                    croppedToInstancesExtent: true
                )
                
                let ciImage = CIImage(cvPixelBuffer: maskedImage)
                
                let context = CIContext()
                guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
                    continuation.resume(throwing: NSError())
                    return
                }
                
                continuation.resume(returning: UIImage(cgImage: cgImage))
            }
        }
    }
}


extension CGImagePropertyOrientation {
    /// UIImage의 Orientation -> CGImage의 Orientation 변환
    init(uiImageOrientation: UIImage.Orientation) {
        switch uiImageOrientation {
        case .up:
            self = .up
        case .down:
            self = .down
        case .left:
            self = .left
        case .right:
            self = .right
        case .upMirrored:
            self = .upMirrored
        case .downMirrored:
            self = .downMirrored
        case .leftMirrored:
            self = .leftMirrored
        case .rightMirrored:
            self = .rightMirrored
        @unknown default:
            self = .up
        }
    }
}
