//
//  CustomAlertView.swift
//  ASCII_Maker
//
//  Created by 문인범 on 11/2/25.
//

import SwiftUI




struct CustomAlertView: View {
    let title: String
    let bodyText: String
    
    let onAppear: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .koreanFont(size: 20)
                .customColor(.secondary)
            
            Text(bodyText)
            .koreanFont(size: 15)
            .foregroundStyle(.white)
        }
        .padding()
        .background {
            Color(hex: "#0D1164")
        }
        .onAppear(perform: onAppear)
    }
}
