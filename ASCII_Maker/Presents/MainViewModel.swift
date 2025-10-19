//
//  MainViewModel.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/17/25.
//

import Foundation


@Observable
class MainViewModel {
    public var screen: ScreenList = .main
    
    public var quality: QualityList = .original
    
    public var isSettingScreenPresented: Bool = false
}


extension MainViewModel {
    enum ScreenList: Identifiable {
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
    }
}
