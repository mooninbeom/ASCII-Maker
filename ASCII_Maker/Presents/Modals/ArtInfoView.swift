//
//  ArtInfoView.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/17/25.
//

import SwiftUI



struct ArtInfoView: View {
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("ASCII Art 란?")
                .koreanFont(size: 20)
                .foregroundStyle(.white)
            
            HStack {
                Image(.doro)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 99)
                
                Spacer()
                
                Image(systemName: "arrowshape.right.fill")
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                
                Spacer()
                
                Image(.doroASCII)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 99)
            }
            
            Text(
                """
                컴퓨터에서 사용되는 아스키(ASCII) 문자, 
                즉 영문 알파벳, 숫자, 특수기호 등 
                단순 텍스트 문자들을 조합해 
                이미지를 표현하는 기법입니다.
                """
            )
            .koreanFont(size: 15)
            .customColor(.secondary)
            
            Button {
                
            } label: {
                ZStack {
                    Rectangle()
                        .customColor(.primary)
                        .frame(height: 50)
                    
                    Text("확인")
                        .koreanFont(size: 20)
                        .foregroundStyle(.white)
                }
            }
        }
        .padding(20)
        .background {
            Color(hex: "#0D1164")
        }
    }
}


#Preview {
    ArtInfoView()
}
