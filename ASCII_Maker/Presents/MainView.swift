//
//  MainView.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/16/25.
//

import SwiftUI



struct MainView: View {
    var body: some View {
        
        ZStack {
            Color.init(hex: "#090B30")
                .ignoresSafeArea()
            
            
            
            
            VStack {
                Button {
                    
                } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 30))
                }
                .customColor(.secondary)
                
                Image(.mainLogo)
                
                Text("내 이미지를 손쉽게 ASCII ART로!")
                
                Text("ASCII ART란?")
                
                Spacer()
                
            }
        }

    }
}



#Preview {
    MainView()
}
