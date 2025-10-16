//
//  ColorManager.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/14/25.
//

import SwiftUI


/**
 Color 익스텐션
 */
extension Color {
    init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") { hexString.removeFirst() }
        
        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        let r, g, b: Double
        
        switch hexString.count {
        case 6:
            r = Double((rgb & 0xFF0000) >> 16) / 255.0
            g = Double((rgb & 0x00FF00) >> 8) / 255.0
            b = Double((rgb & 0x0000FF) >> 16) / 255.0
        default:
            r = 1
            g = 1
            b = 1
        }
        
        self.init(red: r, green: g, blue: b)
    }
}


/**
 ViewModifier 익스텐션
 */
extension View {
    func customColor(_ color: CustomColorModifier.ColorList) -> some View {
        self
            .modifier(CustomColorModifier(color: color))
    }
}

struct CustomColorModifier: ViewModifier {
    enum ColorList: String {
        case background = "#0D1164"
        case text = "#640D5F"
        case primary = "#EA2264"
        case secondary = "#F78D60"
    }
    
    let color: ColorList
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color(hex: color.rawValue))
    }
}
