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
                    .koreanFont(size: 15)
                    .customColor(.secondary)
                
                HStack {
                    Text("ASCII ART란?")
                        .koreanFont(size: 15)
                        .customColor(.secondary)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 10))
                    }
                    .foregroundStyle(.gray)
                }
                
                
                Button {
                    
                } label: {
                    VStack {
                        Text("이미지 선택하기")
                            .koreanFont(size: 15)
                        
                        Image(systemName: "photo")
                            .font(.system(size: 100))
                    }
                }
                .foregroundStyle(.white)
                
                Spacer()
                HStack {
                    VStack {
                        Text("변환 품질")
                            .koreanFont(size: 25)
                            .customColor(.text)
                        
                        qualityButton
                        qualityButton
                        qualityButton
                        qualityButton
                    }
                    
                    Spacer()
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(height: 80)
                            .customColor(.primary)
                        
                        
                        HStack(spacing: 20) {
                            Image(systemName: "photo")
                                .font(.system(size: 30))
                                .foregroundStyle(.white)
                            
                            Image(systemName: "arrowshape.right.fill")
                                .font(.system(size: 18))
                                .foregroundStyle(.white)
                            
                            Image(systemName: "text.quote")
                                .font(.system(size: 30))
                                .foregroundStyle(.white)

                        }
                    }
                }
                

                    
                
            }
            .padding(.horizontal, 30)
        }

    }
    
    private var qualityButton: some View {
        HStack {
            Circle()
                .frame(width: 20, height: 20)
                .foregroundStyle(.white)
                .overlay {
                    Circle()
                        .frame(width: 14, height: 14)
                        .customColor(.primary)
                }
            
            Text("원본 화질")
                .koreanFont(size: 14)
                .foregroundStyle(.white)
        }
    }
}



#Preview {
    MainView()
}
