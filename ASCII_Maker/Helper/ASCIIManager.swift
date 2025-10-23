//
//  ASCIIManager.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/21/25.
//

import UIKit


public enum ASCIIManager {
    static func convertToASCII(image: UIImage, quality: MainViewModel.QualityList) -> String {
        
        let ratio = (image.size.width) / (image.size.height)
        
        let resizedImage: UIImage = {
            switch quality {
            case .original:
                if image.size.width * image.scale > 500 || image.size.height * image.scale > 500 {
                    return image.resizeImage(
                        to: .init(width: 500, height: 500)
                    )
                } else {
                    return image.resizeImage(
                        to: .init(
                            width: image.size.width * image.scale,
                            height: image.size.height * image.scale
                        )
                    )
                }
            default:
                if ratio < 1 {
                    let width = quality.pixels * ratio
                    return image.resizeImage(to: .init(width: width, height: quality.pixels))
                } else {
                    let height = quality.pixels / ratio
                    return image.resizeImage(to: .init(width: quality.pixels, height: height))
                }
            }
        }()
        
        
        guard let cgImage = resizedImage.cgImage,
              let data = cgImage.dataProvider?.data,
              let bytes = CFDataGetBytePtr(data) else {
            fatalError("이미지 데이터 접근 실패")
        }
        
        let bytesPerPixel = cgImage.bitsPerPixel / cgImage.bitsPerComponent
        let width = cgImage.width
        let height = cgImage.height
        
//        let palette = ["@", "#", "%", "&", "W", "M", "$", "8", "o", "."]
        let palette = ["@", "$", "#", "Y", "!", "=", "+", "~", "-", " "]
        
        var resultText = ""
        
        for y in 0 ..< height {
            for x in 0 ..< width {
                let offset = (y * cgImage.bytesPerRow) + (x * bytesPerPixel)
                let r = bytes[offset]
                let g = bytes[offset + 1]
                let b = bytes[offset + 2]
                let alpha = bytes[offset + 3]
                let brightness = (0.299 * Float(r) + 0.587 * Float(g) + 0.114 * Float(b))
                let brightnessLevel = floor(brightness / 25.6)
                
                resultText += alpha == 0 ? " " : palette[Int(brightnessLevel)]
            }
            
            resultText += "\n"
        }
        
        return resultText
    }
}
