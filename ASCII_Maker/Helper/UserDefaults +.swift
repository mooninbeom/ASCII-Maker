//
//  UserDefaults +.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/20/25.
//

import Foundation


extension UserDefaults {
    public static var noMoreGuide: Bool {
        get {
            UserDefaults.standard.bool(forKey: "noMoreGuide")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "noMoreGuide")
        }
    }
}
