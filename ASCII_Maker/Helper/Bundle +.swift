//
//  Bundle +.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/20/25.
//

import Foundation


extension Bundle {
    public var appVersion: String {
        self.infoDictionary?["CFBundleShortVersionString"] as? String ?? "알 수 없음"
    }
    
    public var buildNumber: String {
        self.infoDictionary?["CFBundleVersion"] as? String ?? "알 수 없음"
    }
}
