//
//  SaveImageFailureAlert.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/23/25.
//

import SwiftUI



struct SaveImageFailureAlert: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("저장 실패!")
                .koreanFont(size: 20)
                .customColor(.secondary)
            
            Text(
                """
                저장에 실패했습니다.
                앨범 사용 권한을 확인해주세요.
                """
            )
            .koreanFont(size: 15)
            .foregroundStyle(.white)
        }
        .padding()
        .background {
            Color(hex: "#0D1164")
        }
    }
}
