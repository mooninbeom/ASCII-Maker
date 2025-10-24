//
//  SaveImageCompleteAlert.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/23/25.
//

import SwiftUI



struct SaveImageCompleteAlert: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("저장 완료!")
                .koreanFont(size: 20)
                .customColor(.secondary)
            
            Text("앨범에 저장이 완료되었습니다.")
                .koreanFont(size: 15)
                .foregroundStyle(.white)
        }
        .padding()
        .background {
            Color(hex: "#0D1164")
        }
    }
}



#Preview {
    SaveImageCompleteAlert()
}
