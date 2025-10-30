//
//  RemoveBackgroundFailureAlert.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/24/25.
//

import SwiftUI



struct RemoveBackgroundFailureAlert: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("제거 실패!")
                .koreanFont(size: 20)
                .customColor(.secondary)
            
            Text(
                """
                배경 제거에 실패했습니다.
                다른 이미지를 사용해주세요.
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
