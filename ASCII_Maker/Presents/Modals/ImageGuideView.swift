//
//  ImageGuideView.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/17/25.
//

import SwiftUI




struct ImageGuideView: View {
    
    
    var body: some View {
//        ZStack {
//            Color(hex: "#0D1164")
            
            VStack(alignment: .leading) {
                Text("사진 가이드")
                    .koreanFont(size: 20)
                    .foregroundStyle(.white)
                
                
                HStack {
                    Image(.doro)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 99)
                    
                    Text("✅")
                    
                    Spacer()
                    
                    Image(.wrong)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 99)

                    Text("❌")
                }
                
                Text("""
                     단순한 캐릭터 형식의 이미지를 추천합니다.
                     복잡한 배경이나 인물 사진은 변환 시
                     정확도가 떨어질 수 있습니다.
                     """)
                .koreanFont(size: 15)
                .customColor(.secondary)
                
                Button {
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .customColor(.primary)
                            .frame(height: 50)
                        
                        Text("다음")
                            .koreanFont(size: 20)
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background {
                Color(hex: "#0D1164")
            }
//        }
    }
}



#Preview {
    ImageGuideView()
}
