//
//  FontsManager.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/14/25.
//

import SwiftUI



struct EnglishFontModifier: ViewModifier {
    var size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom("JetBrainsMono-Light", size: size))
    }
}

struct KoreanFontModifier: ViewModifier {
    let size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom("D2Coding", size: size))
    }
}



extension View {
    func englishFont(size: CGFloat) -> some View {
        self
            .modifier(EnglishFontModifier(size: size))
    }
    
    func koreanFont(size: CGFloat) -> some View {
        self
            .modifier(KoreanFontModifier(size: size))
    }
}
