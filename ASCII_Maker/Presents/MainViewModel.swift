//
//  MainViewModel.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/17/25.
//

import SwiftUI
import PhotosUI


@Observable
final class MainViewModel: Sendable {
    public var screen: ScreenList = .main
    
    public var quality: QualityList?
    public var isLoading: Bool = false
    public var resultText: String?
    
    public var backgroundRemovedImage: UIImage?
    
    public var isSettingScreenPresented: Bool = false
    
    public var isASCIIInfomationPresented: Bool = false
    public var isImageGuidePresented: Bool = false
    public var isRemoveBackgroundFailureAlertPresented: Bool = false
    
    public var isPhotosPickerPresented: Bool = false
    public var currentImage: UIImage?
    public var currentPixels: (Int, Int)?
    
    public var originalButton: Bool = true
    public var highButton: Bool = true
    public var mediumButton: Bool = true
    public var lowButton: Bool = true
    
    public var isResultScreenPresented: Bool = false
    
    
    public var photosPickerItem: PhotosPickerItem? {
        didSet {
            Task {
                try await preprocessingImage()
            }
        }
    }
}

extension MainViewModel {
    public var transferButtonDisabled: Bool {
        self.quality == nil
    }
}

extension MainViewModel {
    public func convertButtonTapped() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        guard let image = backgroundRemovedImage ?? currentImage,
              let quality = quality
        else {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return
        }
        
        DispatchQueue.global().async {
            
            let result = ASCIIManager.convertToASCII(image: image, quality: quality)
            
            DispatchQueue.main.async {
                self.resultText = result
                self.isResultScreenPresented = true
                self.isLoading = false
            }
        }
    }
    
    public func removeBackgroundButtonTapped() {
        if backgroundRemovedImage != nil {
            backgroundRemovedImage = nil
            if let image = currentImage {
                self.calibrateImage(image: image)
            }
            
            return
        }
        
        if let image = currentImage {
            self.isLoading = true
            
            Task {
                do {
                    let result = try await image.removeBackground()
                    DispatchQueue.main.async {
                        self.backgroundRemovedImage = result
                        self.calibrateImage(image: result)
                        self.isLoading = false
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.isRemoveBackgroundFailureAlertPresented = true
                        self.isLoading = false
                    }
                }
            }
        }
    }
    
    private func preprocessingImage() async throws {
        if let newItem = try await photosPickerItem?.loadTransferable(type: PhotoTransfer.self) {
            self.currentImage = newItem.image
            calibrateImage(image: newItem.image)
        }
    }
    
    private func calibrateImage(image: UIImage) {
        if let cgImage = image.cgImage {
            let width = cgImage.width
            let height = cgImage.height
            let ratio = width / height
            
            self.currentPixels = (width, height)
            
            self.quality = .original
            originalButton = false
            
            if ratio < 1 {
                if height < 100 {
                    highButton = true
                    mediumButton = true
                    lowButton = true
                } else if height < 200 {
                    highButton = true
                    mediumButton = true
                    lowButton = false
                } else if height < 400 {
                    highButton = true
                    mediumButton = false
                    lowButton = false
                } else {
                    highButton = false
                    mediumButton = false
                    lowButton = false
                }
            } else {
                if width < 100 {
                    highButton = true
                    mediumButton = true
                    lowButton = true
                } else if width < 200 {
                    highButton = true
                    mediumButton = true
                    lowButton = false
                } else if width < 400 {
                    highButton = true
                    mediumButton = false
                    lowButton = false
                } else {
                    highButton = false
                    mediumButton = false
                    lowButton = false
                }
            }
            
        }
    }
}


extension MainViewModel {
    enum ScreenList: Sendable, Identifiable {
        var id: Self { self }
        
        case main
        
        case setting
        case history
        case info
    }
    
    enum QualityList: Int, CaseIterable, Identifiable {
        var id: Self { self }
        
        case original
        case high
        case medium
        case low
        
        public var text: String {
            switch self {
            case .original:
                "원본 화질"
            case .high:
                "높음(400 by 400px)"
            case .medium:
                "중간(200 by 200px)"
            case .low:
                "낮음(100 by 100px)"
            }
        }
        
        public var pixels: CGFloat {
            switch self {
            case .original:
                0
            case .high:
                400
            case .medium:
                200
            case .low:
                100
            }
        }
    }
}
