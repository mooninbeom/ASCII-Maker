//
//  SettingView.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/17/25.
//

import SwiftUI


struct SettingView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("히스토리 >")
                .customColor(.text)
            Text("문의하기 >")
                .customColor(.primary)
            Text("개발자 정보 >")
                .customColor(.secondary)
            
            HStack {
                Spacer()
            }
        }
        .koreanFont(size: 30)
        .background(.clear)
    }
}



#Preview {
    SettingView()
}
