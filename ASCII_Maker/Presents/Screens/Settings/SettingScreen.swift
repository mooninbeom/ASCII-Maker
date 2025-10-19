//
//  SettingScreen.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/17/25.
//

import SwiftUI



struct SettingScreen: View {
    @Binding var viewModel: MainViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            HStack {
                Spacer()
                
                Text("설정")
                    .koreanFont(size: 30)
                    .customColor(.secondary)
                
                Spacer()
                
            }
            .overlay(alignment: .leading) {
                Button("<<<") {
                    withAnimation {
                        self.viewModel.screen = .main
                        self.viewModel.isSettingScreenPresented = false
                    }
                }
                .koreanFont(size: 30)
                .customColor(.secondary)
            }
            
            Text("히스토리 >")
                .customColor(.text)
            Text("문의하기 >")
                .customColor(.primary)
            Text("개발자 정보 >")
                .customColor(.secondary)
            
            HStack {
                Spacer()
            }
            
            Spacer()
        }
        .onAppear {
            self.viewModel.isSettingScreenPresented = true
        }
        .koreanFont(size: 30)
        .padding(.top, 30)
    }
}
