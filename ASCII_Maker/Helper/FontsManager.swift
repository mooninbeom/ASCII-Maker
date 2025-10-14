//
//  FontsManager.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/14/25.
//

import SwiftUI



struct CustomFontModifier: ViewModifier {
    var size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom("JetBrainsMono-Light", size: size))
    }
}



extension View {
    func customFont(size: CGFloat) -> some View {
        self
            .modifier(CustomFontModifier(size: size))
    }
}
